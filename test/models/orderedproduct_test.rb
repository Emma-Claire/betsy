require 'test_helper'

class OrderedproductTest < ActiveSupport::TestCase
  describe "validations" do

    it "requires a quantity" do
      orderedproduct = Orderedproduct.new
      result = orderedproduct.valid?
      result.must_equal false

      orderedproduct.errors.messages.must_include :quantity
    end

    it "must be an integer" do

    end

    it "must be greater than 0" do
    end
  end

  describe "relations" do
    it "can set the order through 'order_id'" do
      op = Orderedproduct.new(quantity: 3)

      op.order = Order.find_by(order_id: 12)
      op.order_id.must_equal orders(:one).id
    end

    it "can set the product through 'product_id'" do
      op = Orderedproduct.new(quantity: 1)

      op.product = Product.find_by(product_id: 43)
      op.product_id.must_equal products(:two).id
    end
  end
end
