class StaticPagesController < ApplicationController
  include Pagy::Backend

  def home
    @pagy, @listings = pagy(Listing.includes([:photos]).where('photos_count > 0'))


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


