class ChangeAtributesColumnOfPlayer < ActiveRecord::Migration[5.1]
  def change
    rename_column :players, :attributes, :additional_info
  end
end
