class Host::ListingsController < ApplicationController
  before_action :set_listing, only: %i[show edit update destroy]
  before_action :authenticate_user!


  def index
    @listings = current_user.listings.all
    @markers = @listings.geocoded.map do |listing|
      {
        lat: listing.latitude,
        lng: listing.longitude
      }
    end
  end

  def new
    @listing = Listing.new
    @show_address = true # or false, depending on your logic
    render 'host/listings/_form'
  end

  def create
    @listing = current_user.listings.new(listing_create_params)
    if @listing.save
      redirect_to host_listing_path(@listing), notice: "Listing was successfully created."
    else
      flash[:errors] = @listing.errors.full_messages
      render :new
    end
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
      flash.now[:errors] = @listing.errors.full_messages
      render :edit
    end
  end

  def show
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
      :adress,
      :city,
      :postal_code,
      :country,
      :max_guests,
      listing_details:{}

    )
  end

  def listing_update_params

    params.require(:listing).permit(
      :title,
      :description,
      :max_guests,
      listing_details:{}
    )
  end

  
end

