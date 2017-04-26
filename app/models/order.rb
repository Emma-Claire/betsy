class Order < ApplicationRecord
  has_many :orderedproducts
  has_many :products, through: :orderedproducts


  #inclusion forces presence to be true!!!!!
  validates :status, inclusion: {
    in: [ "pending", "paid", "shipped", "cancelled" ]
  }

  # do this later
  # validates :email,
  # validates :mailing_address,
  # validates :name_on_cc,
  # validates :cc_num,
  # validates :cc_exp,
  # validates :cc_csv,
  # validates :zip_code,

  # def self.paid_for_merchant(merchant_id)
  #   paid_orders = Order.where(status: "paid")
  #   paid_orders.map { |order| order.products }
  # end

  # def self.for_merchant(merchant_id, status)
  #   orders = Order.where(status: "paid")
  #   orders.each do |order|
  #     order.products.each do |product|
  #       orders.delete(order) if product.merchant_id != merchant_id
  #     end
  #   end
  # end

  def products_for_merchant(merchant_id)
  end
end
