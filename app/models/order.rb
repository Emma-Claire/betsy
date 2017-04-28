class Order < ApplicationRecord
  has_many :orderedproducts
  has_many :products, through: :orderedproducts


  #inclusion forces presence to be true!!!!!
  validates :status, inclusion: {
    in: [ "pending", "paid", "shipped", "cancelled" ]
  }

  # validates :email, presence: true, on: :update
  # validates :mailing_address, presence: true, format: {with: /\A[a-zA-Z0-9 ]+\z/}, on: :update
  # validates :name_on_cc, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters"}, on: :update
  # validates :cc_num, presence: true, numericality: { only_integer: true }, length: { is: 4 }, on: :update
  # validates :cc_exp, presence: true, numericality: { only_integer: true }, length: { is: 4 }, on: :update
  # validates :cc_csv, presence: true, numericality: { only_integer: true }, length: { in: 3..4 }, on: :update
  # validates :zip_code, presence: true, numericality: { only_integer: true }, length: { is: 5 }, on: :update

  def item_total
    orderedproducts.map { |op| op.quantity }.sum
  end

  def verify_inventory
    unavailable = []
    orderedproducts.each do |op|
      unavailable << op.product.name if (op.quantity > op.product.inventory)
    end
    return unavailable
  end

  def modify_inventory(operator)
    unless operator == "-" || operator == "+"
      raise ArgumentError.new("Can only increase or decrease inventory")
    end

    orderedproducts.each do |op|
      op.product.inventory -= op.quantity if operator == "-"
      op.product.inventory += op.quantity if operator == "+"
      op.product.save
    end
  end

  # Updates status of merchant's products in a single order as shipped
  def mark_ops_shipped(merchant_id)
    ops = find_merchant_ops(merchant_id)
    ops.each do |op|
      op.shipped = true
      return false if !op.save
    end
    return true
  end

  # Checks to see if all products in the order have been shipped
  def all_shipped?
    orderedproducts.each do |op|
      return false if !op.shipped
    end
    return true
  end

  # Find an order's orderedproducts for a given merchant
  def find_merchant_ops(merchant_id)
    orderedproducts.select{ |op| op.product.merchant.id == merchant_id }
  end

  def total(merchant_id=nil)
    ops = merchant_id.nil? ? orderedproducts : find_merchant_ops(merchant_id)
    '%.2f' % (ops.map { |op| op.subtotal.to_f }.sum)
  end
end
