class AddCodeToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :code, :string
  end
end
