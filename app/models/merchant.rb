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

  def find_orders
    orders = []
    products.each do |product|
      product.orders.each do |order|
        orders << order if order.status != "pending"
      end
    end
    orders.uniq
    # orders = products.collect{ |product| product.orders }
    # orders.flatten.uniq
    # orderedproducts.each do |op|
    #   order = op.order
    #   orders[order.id] += op if order.status != "pending"
    #
    # end
  end

  def orders_by_status
    @orders = find_orders.group_by { |order| order.status }
    ["paid", "shipped", "cancelled"].each do |status|
      @orders[status] = [] if !@orders.keys.include? status
    end
    return @orders
  end
end
