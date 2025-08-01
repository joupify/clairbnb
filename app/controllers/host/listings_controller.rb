class Host::ListingsController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!
  before_action :set_listing, only: %i[show edit update destroy]


  def index
    
    @pagy, @listings = pagy(current_user.listings.includes([:photos, :host]).where('photos_count > 0'))

    
    @markers = @listings.geocoded.map do |listing|
      {
        latitude: listing.latitude,
        longitude: listing.longitude
      }
    end
  end

  def new
    @listing = Listing.new
    @show_address = true # or false, depending on your logic
    # render 'host/listings/_form'
  end

  def create
    @listing = current_user.listings.new(listing_create_params)
    if @listing.save
      redirect_to host_listing_path(@listing), notice: "Listing was successfully created."
      format.turbo_stream

    else
      flash[:errors] = @listing.errors.full_messages
      render :new
      # format.turbo_stream { render turbo_stream: turbo_stream.replace("room_form", partial: "host/rooms/form", locals: { listing: @listing, room: @room }) }

    end
  end


  def show
    # Find a specific room or create a new one if none exists for this listing
    # @room = @listing.rooms.new
    @room = Room.new

    @bed = @room.beds.new
    @photo = @listing.photos.new
    @rooms = @listing.rooms

  end


  def edit
    @show_address = false # or false, depending on your logic
    render 'host/listings/_form'
  end
  
  def update
    @listing = current_user.listings.find(params[:id])
    if @listing.update(listing_update_params)
      redirect_to host_listing_path(@listing), notice: "Listing was successfully updated."
    else
      puts "Update failed. Errors: #{@listing.errors}"
      flash.now[:errors] = @listing.errors.full_messages
      render :edit
    end
  end
  


  def destroy
    @listing.archived!
    redirect_to host_listings_path, notice: "Listing destroyed successfully."
  end

  private 

  def set_listing
    @listing = current_user.listings.find(params[:id])
  end

  def listing_create_params

    params.require(:listing).permit(
      :title,
      :description,
      :address,
      :city,
      :postal_code,
      :country,
      :max_guests,
      :nightly_price,
      :cleaning_fee,
      photos_attributes: [:id, :image, :caption]


    )
  end

  def listing_update_params

    params.require(:listing).permit(
      :title,
      :description,
      :max_guests,
      :status,
      :nightly_price,
      :cleaning_fee,
      photos_attributes: [:id, :image, :caption]
    )
  end

  
end

