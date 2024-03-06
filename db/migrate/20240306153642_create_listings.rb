class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.references :host, null: false, foreign_key: {to_table: :users}
      t.string :title, null: false
      t.string :description
      t.string :adress
      t.string :city
      t.string :postal_code
      t.string :country
      t.decimal :lat, precision: 10 ,   scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.integer :max_guests, default: 1
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
