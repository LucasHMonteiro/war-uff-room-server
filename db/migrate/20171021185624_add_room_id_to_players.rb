class AddRoomIdToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_reference :players, :room, foreign_key: true
  end
end
