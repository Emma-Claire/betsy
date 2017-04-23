require 'test_helper'

class OrderedproductTest < ActiveSupport::TestCase
  describe "validations" do
    it "can be created with all attributes" do
      Orderedproduct.create!(
      quantity: 12,
      order: orders(:paid),
      product: products(:aloe)
      )
    end

    it "requires a quantity" do
      orderedproduct = Orderedproduct.new
      orderedproduct.valid?.must_equal false
      orderedproduct.errors.messages.must_include :quantity
    end

    it "requires the quantity to be an integer" do
      orderedproduct = Orderedproduct.new(quantity: "ab")
      orderedproduct.valid?.must_equal false
      orderedproduct.errors.messages.must_include :quantity
    end

    it "must be greater than 0" do
      orderedproduct = Orderedproduct.new(quantity: 0)
      orderedproduct.valid?.must_equal false
      orderedproduct.errors.messages.must_include :quantity
    end

    # need test for negative numbers?
  end

  describe "relations" do
    let (:op) {Orderedproduct.new(quantity: 3)}
    it "can set the order through 'order'" do
      op.order = orders(:pending)
      op.order_id.must_equal orders(:pending).id
    end

    it "can set the order through 'order_id'" do
      op.order_id = orders(:pending).id
      op.order.must_equal orders(:pending)
    end

    it "can set the product through 'product'" do
      op.product = products(:century)
      op.product_id.must_equal products(:century).id
    end
    it "can set the product through 'product_id'" do
      op.product_id = products(:aloe).id
      op.product.must_equal products(:aloe)
    end
  end
end
