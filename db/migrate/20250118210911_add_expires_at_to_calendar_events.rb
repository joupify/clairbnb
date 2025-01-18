class AddExpiresAtToCalendarEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :calendar_events, :expires_at, :datetime
  end
end
