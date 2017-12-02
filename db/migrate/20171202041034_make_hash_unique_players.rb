class MakeHashUniquePlayers < ActiveRecord::Migration[5.1]
  def change
    add_index :players, :hash, unique: true
  end
end
