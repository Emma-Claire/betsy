class AddRetireColumnToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :retired, :boolean
  end
end
