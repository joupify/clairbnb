class Host::PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    @listing = current_user.listings.find(params[:listing_id])
    @photos = @listing.photos
    @photo = Photo.new # Initialize a new photo object
  end

  def new
    @listing = current_user.listings.find(params[:listing_id])
    @photo = @listing.photos.new
  end

  def show
    @listing = current_user.listings.find(params[:listing_id])
    @photo = @listing.photos.find(params[:id])

  end

  def create
    @listing = current_user.listings.find(params[:listing_id])
    @photo = @listing.photos.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to host_listing_photos_path(@listing), notice: 'Photo successfully created.' }
      else
        flash[:errors] = @photo.errors.full_messages
        format.html { render :new }
      end
    end
  end
  


  def destroy
    @listing = Listing.find(params[:listing_id])
    @photo = @listing.photos.find(params[:id])
    @photo.destroy

    redirect_to host_listing_photos_path(@listing), notice: 'Photo successfully detroyed.'
    
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
end

