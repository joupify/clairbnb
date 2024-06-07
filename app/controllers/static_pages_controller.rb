class StaticPagesController < ApplicationController
  def home
    @listings = Listing.includes(:photos).where.not(photos: { id: nil })
  end

  def dashboard

     @listings = current_user.listings.includes(:photos).where.not(photos: { id: nil })
    
    if params[:status]
      @reservations = current_user.reservations.where(status: params[:status])
    else
      @reservations = current_user.reservations
    end
  end
end
