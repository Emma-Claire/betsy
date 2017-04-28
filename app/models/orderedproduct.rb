class Orderedproduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validate :cannot_put_more_items_in_cart_than_are_available_in_inventory, on: :update

  after_initialize :set_defaults, unless: :persisted?

  def cannot_put_more_items_in_cart_than_are_available_in_inventory # ^_^
    product = Product.find_by(id: product_id)
    if quantity > product.inventory
      errors.add(:quantity, "The quantity requested is not available")
    end
  end

  def subtotal
    '%.2f' % (product.price * quantity)
  end

  private
  def set_defaults
    self.shipped = false if self.shipped.nil?
  end

end
