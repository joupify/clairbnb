class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: %i[new create]


  def show
    @reservation = current_user.listings.map { |listing| listing.reservations.find_by(id: params[:id]) }.compact.first
    # If there's no reservation found with the given id, @reservation will be nil
    @listing = @reservation.listing

  end
  
    def create
      @listing = Listing.find(params[:listing_id])
      @reservation= @listing.reservations.new(reservation_params)
      @reservation.listing = @listing
      @reservation.guest = current_user
  
      if @reservation.save 
        # create checkout session
        listing = @reservation.listing
        checkout_session = Stripe::Checkout::Session.create(
          success_url: listing_reservation_url(@listing, @reservation),
          cancel_url: listing_url(listing),
          customer: current_user.stripe_customer_id,
          mode: 'payment',
          line_items: [{
            price_data: {
              unit_amount: listing.nightly_price,
              currency: 'eur', # Corrected currency code to 'eur'
              product: listing.stripe_product_id,
            }, 
            quantity: 1 # How many nights they booked?
          }, {
            price_data: {
              unit_amount: listing.cleaning_fee,
              currency: 'eur', # Corrected currency code to 'eur'
              product: 'prod_PkaFnbaqbZmyqs', # Cleaning_fee product_id
            },
            quantity: 1
          }],
          metadata: {
            reservation_id: @reservation.id,
          },
          payment_intent_data: {
            metadata: {
              reservation_id: @reservation.id,

            }

          }
        )
        @reservation.update(session_id: checkout_session.id)
        redirect_to checkout_session.url, allow_other_host: true
      else
        render :'listing/show', status: :unprocessable_entity
      end
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

    private
  
    def set_listing
      @listing = Listing.find(params[:listing_id])
    end
  
    def reservation_params
      params.require(:reservation).permit(:listing_id, :guest_id, :session_id, :status)
    end
  

end