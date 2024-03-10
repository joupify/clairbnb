class Host::RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @listing = current_user.listings.find(params[:listing_id])
    @rooms = @listing.rooms.all
  end
end
