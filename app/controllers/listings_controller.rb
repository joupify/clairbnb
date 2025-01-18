class ListingsController < ApplicationController
include Pagy::Backend

def index
  @pagy, @listings = pagy(Listing.published.includes([:photos, :host]).where('photos_count > 0'))


  if params[:city].present?
    @listings = @listings.where("city ILIKE ?", "%#{params[:city]}%")
  end
  if params[:checkin].present? && params[:checkout].present?
    checkin_date = Date.parse(params[:checkin])
    checkout_date = Date.parse(params[:checkout])
    # Find reservations that overlap with the specified date range and are booked
    overlapping_booked_reservations = Reservation.joins(:calendar_event)
                                                  .where("(calendar_events.start_date <= ? AND calendar_events.end_date >= ?) OR 
                                                          (calendar_events.start_date >= ? AND calendar_events.end_date <= ?) OR 
                                                          (calendar_events.start_date <= ? AND calendar_events.end_date >= ?)", 
                                                          checkin_date, checkin_date, checkin_date, checkout_date, checkout_date, checkout_date)
                                                  .where(status: 'booked')

    # Exclude listings with overlapping booked reservations
    @listings = @listings.where.not(id: overlapping_booked_reservations.pluck(:listing_id))
  end
  if params[:guests].present? && !params[:guests].empty?
    # Convert the guest count to an integer
  guest_count = params[:guests].to_i

  # Bed sizes array from the enum values
  bed_sizes = Bed.bed_sizes.values_at(:twin, :twin_xl, :full)

  # Find listings where the total capacity of all beds meets or exceeds the guest count
  @listings = @listings.joins(rooms: :beds)
                       .group('listings.id')
                       .having('SUM(CASE WHEN beds.bed_size IN (?) THEN 1 ELSE 2 END) >= ?', bed_sizes, guest_count)
  end
end

  def show
    @listing = Listing.published.find(params[:id])
    @reservation = Reservation.new
    @unavailable_dates = @listing.unavailable_dates

  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Listing not found or not published"
    redirect_to root_path 
  end

  def search
    location = params[:destination]
    check_in = params[:checkin]
    check_out = params[:checkout]
    guests = params[:guests]

    @listings = Listing.where(location: location)
                       .where("check_in <= ?", check_in)
                       .where("check_out >= ?", check_out)
                       .where("max_guests >= ?", guests)
  end
    # Process the search parameters
    # Perform the search query
    # Display the search results
  


    # used to display the next  photos
    def show_more_photos
      @listing = Listing.find(params[:id])
      @additional_photos = @listing.photos.drop(5) 
  
      # respond_to do |format|
      #   # format.turbo_stream
      #   format.html { redirect_to listing_path(@listing) } # Fallback for non-Turbo requests
      # end
    end

end
