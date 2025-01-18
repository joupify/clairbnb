class AddBedsCountToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :beds_count, :integer, default: 0, null: false
    
    Room.find_each do |room|
      Room.reset_counters(room.id, :beds)
    end
  end
end
