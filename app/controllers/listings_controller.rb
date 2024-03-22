class ListingsController < ApplicationController
include Pagy::Backend

  def index
    @pagy, @listings = pagy(Listing.published, items: 6)


  end

  def show
    
    @listing = Listing.published.find(params[:id])
    @reservation = Reservation.new
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Listing not found or not published"
    redirect_to root_path # or any other path you prefer
  end
  
end
