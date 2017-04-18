class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.belongs_to :product

      t.timestamps
    end
  end
end
