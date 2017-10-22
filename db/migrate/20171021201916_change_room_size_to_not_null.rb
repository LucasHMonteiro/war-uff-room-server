class ChangeRoomSizeToNotNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null :rooms, :free_space, false
  end
end
