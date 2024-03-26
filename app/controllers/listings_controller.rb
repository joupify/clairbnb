class ListingsController < ApplicationController
include Pagy::Backend

def index
  @listings = Listing.published

  if params[:query].present?
    @listings = @listings.where("city ILIKE ?", "%#{params[:query]}%")
  end

  if params[:checkin].present? && params[:checkout].present?
    checkin_date = Date.parse(params[:checkin])
    checkout_date = Date.parse(params[:checkout])
    reservation_ids = CalendarEvent.where("(start_date <= ? AND end_date >= ?) OR (start_date >= ? AND end_date <= ?) OR (start_date <= ? AND end_date >= ?)", checkin_date, checkin_date, checkin_date, checkout_date, checkout_date, checkout_date).pluck(:id)
    puts reservation_ids
    @listings = @listings.joins(:reservations).where.not(reservations: { id: reservation_ids }).distinct
  end


    
      if params[:guests].present?
        @listings = @listings.where("max_guests >= ?", params[:guests])
      end
    

    # if params[:destination].present? || params[:checkin].present? || params[:checkout].present? || params[:guests].present?
    #   search
    #   render :search
    # else
    #  @listings = Listing.published
    # end
  end

  def show
    @listing = Listing.published.find(params[:id])
    @reservation = Reservation.new
    # @unavailable_dates = @listing.calendar_events.unavailable_dates
    # @unavailable_dates = @listing.calendar_events.map(&:unavailable_dates) # call on each calendar_event
    @unavailable_dates = @listing.unavailable_dates

  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Listing not found or not published"
    redirect_to root_path # or any other path you prefer
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
  
end
