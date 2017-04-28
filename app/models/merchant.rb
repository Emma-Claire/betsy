class Merchant < ApplicationRecord
  has_many :products
  has_many :orderedproducts, through: :products
  # has_many :orders, through: :orders

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  def self.from_github(auth_hash)
    user = Merchant.new
    user.username = auth_hash['info']['nickname']
    user.oauth_uid = auth_hash['uid']
    user.email = auth_hash['info']['email']
    user.oauth_provider = 'github'
    return user
  end

  def orderedproducts_by_status
    paid = orderedproducts.select { |op| op.order.status == "paid" && !op.shipped }
    shipped = orderedproducts.select { |op| op.order.status == "shipped" || op.shipped }
    cancelled = orderedproducts.select { |op| op.order.status == "cancelled" }
    return { "paid" => paid, "shipped" => shipped, "cancelled" => cancelled }
  end

  def build_orders_hash
    ops_by_status = orderedproducts_by_status
    orders_hash = {}

    ops_by_status.each do |status, ops|
      orders = {}
      ops.each do |op|
        if !orders.key?(op.order.id)
        orders[op.order.id] = []
        end
        orders[op.order.id] << op
      end
      orders_hash[status] = orders
    end
    return orders_hash
  end

  def total_revenue
    ops = orderedproducts.select { |op| op.order.status != "cancelled" }
    '%.2f' % (ops.map { |op| op.subtotal.to_f }.sum)
  end
end
