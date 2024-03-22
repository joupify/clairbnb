class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: %i[new create]

  def index
    @reservations = current_user.reservations
    @host_reservations = current_user.host_reservations
    puts "@host_reservations: #{@host_reservations.inspect}" # Add this line for debugging

  end
  

  def show
    @reservation = current_user.reservations.find(params[:id])
    # @reservation = current_user.listings.map { |listing| listing.reservations.find_by(id: params[:id]) }.compact.first
    # If there's no reservation found with the given id, @reservation will be nil
     @listing = @reservation.listing
  end

  def new
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new
    @calendar_events = @listing.calendar_events
  end
  
    def create
      @booking = BookListing.new(current_user, reservation_params)

      if @booking.save
        redirect_to @booking.checkout_url, allow_other_host: true, status: :see_other

      else
        flash.now[:errors] = @booking.errors
        @listing = @booking.listing
        @calendar_events = @listing.calendar_events
        render :new
      end




      # @listing = Listing.find(params[:listing_id])
      # @reservation= @listing.reservations.new(reservation_params)
      # @reservation.listing = @listing
      # @reservation.guest = current_user
  
      # if @reservation.save 
      #   # create checkout session
      #   listing = @reservation.listing
      #   checkout_session = Stripe::Checkout::Session.create(
      #     success_url: listing_reservation_url(@listing, @reservation),
      #     cancel_url: listing_url(listing),
      #     customer: current_user.stripe_customer_id,
      #     mode: 'payment',
      #     line_items: [{
      #       price_data: {
      #         unit_amount: listing.nightly_price,
      #         currency: 'eur', # Corrected currency code to 'eur'
      #         product: listing.stripe_product_id,
      #       }, 
      #       quantity: 1 # How many nights they booked?
      #     }, {
      #       price_data: {
      #         unit_amount: listing.cleaning_fee,
      #         currency: 'eur', # Corrected currency code to 'eur'
      #         product: 'prod_PkaFnbaqbZmyqs', # Cleaning_fee product_id
      #       },
      #       quantity: 1
      #     }],
      #     metadata: {
      #       reservation_id: @reservation.id,
      #     },
      #     payment_intent_data: {
      #       #application_fee_amount: ((listing.cleaning_fee + listing.nightly_price) * 0.10).to_i,
      #       # transfer_data: {
      #       # destination: listing.host.stripe_account_id

      #     # },
      #       metadata: {
      #         reservation_id: @reservation.id,

      #       }

      #     }
      #   )
      #   @reservation.update(session_id: checkout_session.id)
      #   redirect_to checkout_session.url, allow_other_host: true
      # else
    #     render :'listing/show', status: :unprocessable_entity
    #   end
     end
  

    def cancel
      @listing = current_user.listings.find(params[:listing_id])
      @reservation = @listing.reservations.find(params[:id])
      refund = Stripe::Refund.create({
        payment_intent: @reservation.stripe_payment_intent_id
      })
      @reservation.update(status: :canceling, stripe_refund_id: refund.id)
      redirect_to action: "show", id: @reservation
    end

    def expire
      session_id = params[:session_id]  # Store it in a variable for clarity
    
      if session_id.present?  # Check if it's not nil
        Stripe::Checkout::Session.expire(session_id)
      end
    
      redirect_to listings_path  # Redirect to listings_path regardless
    end
    
    private
  
    def set_listing
      @listing = Listing.find(params[:listing_id])
    end
  
    def reservation_params
      params.require(:reservation).permit(:listing_id, :guest_id, :session_id, :status, :start_date, :end_date)
    end
  

end