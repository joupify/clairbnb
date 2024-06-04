class AddUserToWebpushNotification < ActiveRecord::Migration[7.0]
  def change
    add_reference :webpush_notifications, :user, null: false, foreign_key: true
  end
end
