class AddPhotosCountToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :photos_count, :integer, default: 0, null: false

    Listing.find_each do |listing|
      Listing.reset_counters(listing.id, :photos)
    end
  end
end
