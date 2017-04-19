require 'test_helper'

describe Order do
  let(:bad_order) { Order.create(status: "Lau") }
  let(:blank_status_order) { Order.create(status: " ") }

  describe "relationship with orderedproducts" do
    it "one order has to have one or more orderedproducts" do
      orders(:pending).must_respond_to :orderedproducts
    end
  end

  describe "Validations" do
    it "4 posible status must be valid" do
      orders(:pending).must_be :valid?
      orders(:paid).must_be :valid?
      orders(:shipped).must_be :valid?
      orders(:cancelled).must_be :valid?
    end

    it "Do not let create a new order with a blank status" do
      blank_status_order.valid?.must_equal false
    end

    it "Do not let create a new order without a right status" do
      bad_order.valid?.must_equal false
    end
  end
end
