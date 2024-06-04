class CreateDeliveryMethodsWebpushes < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_methods_webpushes do |t|

      t.timestamps
    end
  end
end
