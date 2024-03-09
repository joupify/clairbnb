class RenameLatAndLngToLatitudeAndLongitudeInListings < ActiveRecord::Migration[7.0]
  def change
    rename_column :listings, :lat, :latitude
    rename_column :listings, :lng, :longitude

  end
end
