class StaticPagesController < ApplicationController
  def home
    @listings = Listing.includes(:photos).where.not(photos: { id: nil })
  end
end
