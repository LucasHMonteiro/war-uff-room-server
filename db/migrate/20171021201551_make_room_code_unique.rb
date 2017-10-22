class MakeRoomCodeUnique < ActiveRecord::Migration[5.1]
  def change
    add_index :rooms, :code, unique: true
  end
end
