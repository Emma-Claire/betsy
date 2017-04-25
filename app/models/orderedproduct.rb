class Orderedproduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validate :cannot_put_more_items_in_cart_than_are_available_in_inventory, on: :update

  # def check_inventory
  #   product = Product.find_by(id: product_id)
  #   if quantity <= product.inventory
  #     return true
  #   else
  #     return false
  #   end
  # end

  def cannot_put_more_items_in_cart_than_are_available_in_inventory # ^_^
    product = Product.find_by(id: product_id)
    if quantity > product.inventory
      errors.add(:quantity, "The quantity requested is not available")
    end
  end

  def self.cart_quantity(order_id)
    ops = Orderedproduct.where(order_id: order_id)
    sum = 0
    ops.each do |product|
      sum += product.quantity
    end
    return sum
  end

  # def cart_quantity
  #   @ops = Orderedproduct.find_by(product_id: params[:product_id])
  #   @ops.each do |product|
  #     quantity = 0
  #     quantity += product.count
  #   end
  #   return quantity
  # end

  # assume only called on an array?

end
