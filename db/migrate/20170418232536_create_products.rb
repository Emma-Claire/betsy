class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :category
      t.text :description
      t.integer :inventory
      t.string :photo_url
      t.belongs_to :merchant

      t.timestamps
    end
  end
end
