class ListingsController < ApplicationController
include Pagy::Backend

  def index
    @pagy, @listings = pagy(Listing.published, items: 6)


  end

  def show

    @listing = Listing.published.find(params[:id])
    @reservation = Reservation.new
    # @unavailable_dates = @listing.calendar_events.unavailable_dates
    # @unavailable_dates = @listing.calendar_events.map(&:unavailable_dates) # call on each calendar_event
    @unavailable_dates = @listing.unavailable_dates


  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Listing not found or not published"
    redirect_to root_path # or any other path you prefer
  end

  
end
