class ChangeHashColumnNamePlayers < ActiveRecord::Migration[5.1]
  def change
    rename_column :players, :hash, :identity
  end
end
