class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: %i[new create]

  def index
    
    @reservations = current_user.reservations.order(id: :desc).includes(:listing, :calendar_event)
    @host_reservations = current_user.host_reservations.order(id: :desc).includes(:guest, :calendar_event)

    if params[:status]
      @reservations = @reservations.where(status: params[:status])
      @host_reservations = @host_reservations.where(status: params[:status])
      else  
      @reservations = @reservations
    end
  end

  def show
    @reservation = current_user.reservations.find(params[:id])
    @listing = @reservation.listing
    @message = Message.new
  end

  def new
    @reservation = Reservation.new
    @calendar_events = @listing.calendar_events
    @message = Message.new

    unavailable_events = CalendarEvent.where(listing_id: @listing.id)
                                      .where.not(status: :reserved)
                                      .or(CalendarEvent.where(listing_id: @listing.id, status: :reserved, reservation_id: nil))
                                      .or(CalendarEvent.where(listing_id: @listing.id, reservation_id: Reservation.where(status: :booked).pluck(:id)))
                                      .pluck(:start_date, :end_date)

    @unavailable_dates = unavailable_events.flat_map do |start_date, end_date|
      if start_date == end_date - 1
        [start_date]
      else
        (start_date..end_date).to_a
      end
    end
  end

  def create
    start_date = params[:reservation][:start_date]
    end_date = params[:reservation][:end_date]

    @reservation = Reservation.new(reservation_params)
    @reservation.guest = current_user
    @reservation.listing = @listing

    calendar_event = CalendarEvent.new(
      listing: @listing,
      reservation: @reservation,
      status: :reserved,
      start_date: start_date,
      end_date: end_date
    )

    if @reservation.valid? && calendar_event.valid?
      ActiveRecord::Base.transaction do
        calendar_event.save!
        @reservation.save!

        checkout_session = Stripe::Checkout::Session.create(
          success_url: listing_reservation_url(@listing, @reservation),
          cancel_url: expire_listing_reservation_url(@listing, @reservation) + "?session_id={CHECKOUT_SESSION_ID}",
          customer: current_user.stripe_customer_id,
          mode: 'payment',
          allow_promotion_codes: true,
          expires_at: 1.hour.from_now.to_i,
          submit_type: 'book',
          line_items: [
            {
              price_data: {
                unit_amount: @listing.nightly_price,
                currency: 'usd',
                product: @listing.stripe_product_id
              },
              quantity: @reservation.nights
            },
            {
              price_data: {
                unit_amount: @listing.cleaning_fee,
                currency: 'usd',
                product: 'prod_PkaFnbaqbZmyqs'
              },
              quantity: 1
            }
          ],
          metadata: {
            reservation_id: @reservation.id,
            listing_id: @listing.id,
            guest_id: current_user.id,
            start_date: @reservation.start_date,
            end_date: @reservation.end_date
          },
          payment_intent_data: {
            metadata: {
              reservation_id: @reservation.id,
              listing_id: @listing.id,
              guest_id: current_user.id,
              start_date: @reservation.start_date,
              end_date: @reservation.end_date
            }
          }
        )

        @reservation.update!(session_id: checkout_session.id)
        redirect_to checkout_session.url, allow_other_host: true, status: :see_other

        
         notification = GuestReservationBookedNotification.with(reservation: @reservation)
         notification.deliver(@reservation.guest) # Assuming guest is the recipient
         notification.deliver(@reservation.host)  # Assuming host is also a recipient
      end
    else
      flash.now[:errors] = @reservation.errors.full_messages + calendar_event.errors.full_messages
      @calendar_events = @listing.calendar_events
      render :new
    end
  end

  def cancel
    @listing = current_user.listings.find(params[:listing_id])
    @reservation = @listing.reservations.find(params[:id])
    refund = Stripe::Refund.create({ payment_intent: @reservation.stripe_payment_intent_id })
    @reservation.update(status: :canceling, stripe_refund_id: refund.id)
    redirect_to action: "show", id: @reservation
  end

  def expire
    session_id = params[:session_id]
    Stripe::Checkout::Session.expire(session_id) if session_id.present?
    redirect_to listings_path
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def reservation_params
    params.require(:reservation).permit(:listing_id, :guest_id, :session_id, :status)
  end
end