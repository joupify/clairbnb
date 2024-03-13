class RenameAdressToAddressInListings < ActiveRecord::Migration[7.0]
  def change
    rename_column :listings, :adress, :address
  end
end
