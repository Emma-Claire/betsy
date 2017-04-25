class Orderedproduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

#need to wrote code to keep user from putting more items in cart than are in inventory
  # validates :quantity, numericality: { only_integer: true, greater_than: 0, less_than: :product.inventory }, on: :update

  # def check_inventory
  #   product = Product.find_by(id: product_id)
  #   if quantity <= product.inventory
  #     return true
  #   else
  #     return false
  #   end
  # end

end
