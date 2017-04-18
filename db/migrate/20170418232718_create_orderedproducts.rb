class CreateOrderedproducts < ActiveRecord::Migration[5.0]
  def change
    create_table :orderedproducts do |t|
      t.integer :quantity

      t.timestamps
    end
  end
end
