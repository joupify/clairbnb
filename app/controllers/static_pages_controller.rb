class StaticPagesController < ApplicationController
  def home
    @listings = Listing.includes(:photos).where.not(photos: { id: nil })
  end

  def dashboard
    @listings = current_user.listings.includes(:photos).where.not(photos: { id: nil })
   @reservations = current_user.reservations.includes(:listing).where.not(listings: { id: nil })

   
  end
  
  
end
