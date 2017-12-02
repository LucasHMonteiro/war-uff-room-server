class AddHashToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :hash, :string
  end
end
