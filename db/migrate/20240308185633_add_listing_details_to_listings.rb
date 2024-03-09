class AddListingDetailsToListings < ActiveRecord::Migration[7.0]   
  def change
    add_column :listings, :listing_details, :jsonb, default: {
      'number_of_rooms': nil,
      'number_of_beds': nil,
      'bed_size': nil,
      'roomType': nil 
    }
    add_index :listings, :listing_details, using: :gin
  end
end
