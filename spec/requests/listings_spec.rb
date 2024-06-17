require 'rails_helper'

RSpec.describe "Listings", type: :request do
  let(:user) { create(:user) }
  let(:host) { create(:host) }
  let(:guest) { create(:user, :guest) }
  let!(:host_listing) { create(:listing, host: host) }


  before do
    sign_in user
  end

  describe "GET /index" do
    let!(:host_listing) { create(:listing, host: host) }
    let!(:guest_listing) { create(:listing, host: guest) }

    it "should return index page" do
      get listings_path
      expect(response).to be_successful
    end

    it "should return index page with listings belonging to the current user" do
      get listings_path
      expect(assigns(:listings)).not_to include(host_listing)
      expect(assigns(:listings)).not_to include(guest_listing)
    end
  end


# describe "GET lisitngs#index" do 
# context "when the user is a host" do 
#     it "should list titles of all listings" do
#            host = create(:host) 
#            listings = create_list(:listing, 10, host: host)
#            login_as(host, scope: :user) 
#            visit listings_path
#            listings.each do |listing|  
#            page.should have_content(listing.title)  
#            end 
#      end
#  end

# end


  # desribe "GET /show" do
  #   let (:room) { create(:room, listing: listing) }
  #   let (:bed) { create(:bed, room: room) }
  #   let (:photos) { create_list(:photo, 3, listing: listing) }

  #   it "it should return the show page" do
  #     get listing_path(listing)
  #     expect
  #   end
      
  # end
  
end


