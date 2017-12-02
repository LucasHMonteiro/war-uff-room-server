class AddAtributesToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :attributes, :text
  end
end
