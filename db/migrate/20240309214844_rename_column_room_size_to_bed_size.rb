class RenameColumnRoomSizeToBedSize < ActiveRecord::Migration[7.0]
  def change
    rename_column :beds, :room_size, :bed_size
  end
end
