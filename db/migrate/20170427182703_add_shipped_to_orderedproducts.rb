class AddShippedToOrderedproducts < ActiveRecord::Migration[5.0]
  def change
    add_column :orderedproducts, :shipped, :boolean
  end
end
