class Host::RoomsController < ApplicationController
  before_action :authenticate_user!


  def index
    @listing = current_user.listings.find(params[:listing_id])
    @rooms = @listing.rooms.all
    @room = Room.new  # Ensure @room is initialized

  end

  def new
    @listing = current_user.listings.find(params[:listing_id])
    @room = Room.new # Initialize a new room instance
  end

  # app/controllers/host/rooms_controller.rb

  def create
    @listing = Listing.find(params[:listing_id])
    @room = @listing.rooms.new(room_params)
  
    respond_to do |format|
      if @room.save
        format.html { redirect_to host_listing_rooms_path(@listing), notice: 'Room successfully created.' }
      else
        flash[:errors] = @room.errors.full_messages
        format.html { render :new } # Render the new room form again
      end
    end
  end

  def destroy
    @listing = Listing.find(params[:listing_id])
    @room = @listing.rooms.find(params[:id])
    @room.destroy

    redirect_to host_listing_rooms_path(@listing), notice: 'Room successfully detroyed.'
  end
  

  private

  def room_params
    params.require(:room).permit(:room_type, beds_attributes: [:bed_size])
  end
end


  

