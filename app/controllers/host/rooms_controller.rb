class Host::RoomsController < ApplicationController
  before_action :authenticate_user!


  def index
    @listing = current_user.listings.find(params[:listing_id])
    @rooms = @listing.rooms.includes(:beds) # Eager loading beds

    

    @room = Room.new  # Ensure @room is initialized
    # render partial: "host/rooms/room", locals: { listing: @listing, show_rooms: @show_rooms }


  end

  def new
    @listing = current_user.listings.find(params[:listing_id])
    @room = Room.new # Initialize a new room instance
  end

  # app/controllers/host/rooms_controller.rb

  def create
    @listing = Listing.find(params[:listing_id])
    @room = @listing.rooms.new(room_params)
  
    if @room.save
      @rooms = @listing.rooms.includes(:beds) # Eager loading beds

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("rooms", partial: "host/rooms/room", locals: { room: @room, listing: @listing }),
            turbo_stream.append("rooms", partial: "host/listings/rooms_list", locals: { listing: @listing })
          ]
        end
        format.html { redirect_to host_listing_path(@listing), notice: 'Room was successfully created.' }
      end
      else
        flash[:errors] = @room.errors.full_messages
        format.html { render :new } 
      end
    end


  def destroy
    @room = Room.find(params[:id])
    @listing = @room.listing

    if @room.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.remove(@room),
            turbo_stream.replace(
              "rooms",
              partial: 'host/listings/rooms_list',
              locals: { listing: @listing }
            )
          ]
        end
      end
    else
      flash[:errors] = @room.errors.full_messages
      format.html { redirect_to host_listing_path(@listing) }
  end
  end
  
  # def destroy
  #   @listing = Listing.find(params[:listing_id])
  #   @room = @listing.rooms.find(params[:id])
  #   @room.destroy
    
  #   respond_to do |format|
  #     format.turbo_stream { render turbo_stream: turbo_stream.remove(@room) }
  #     format.html { redirect_to host_listing_path(@listing), notice: 'Room was successfully deleted.' }
  #   end
  # end





  # def destroy
  #   @listing = Listing.find(params[:listing_id])
  #   @room = @listing.rooms.find(params[:id])
  #   @room.destroy

  #   redirect_to host_listing_rooms_path(@listing), notice: 'Room successfully detroyed.'
  # end
  

  private

  def room_params
    params.require(:room).permit(:room_type, beds_attributes: [:bed_size])
  end
end


  

