class ListingsController < ApplicationController
  def index
    @listings = Listing.published
  end

  def show
    
    @listing = Listing.published.find(params[:id])
    @reservation = Reservation.new
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Listing not found or not published"
    redirect_to root_path # or any other path you prefer
  end
  
end
