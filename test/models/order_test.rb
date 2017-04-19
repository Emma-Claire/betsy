require 'test_helper'

describe Order do
  describe "Validations" do
    it "must be valid" do
      orders(:pending).must_be :valid?
      orders(:paid).must_be :valid?
      orders(:shipped).must_be :valid?
      orders(:cancelled).must_be :valid?
      orders(:fake).valid?.must_equal false
      orders(:no_status).valid?.must_equal false
    end

    it "Do not let create a new order without a status" do
      Order.new.valid?.must_equal false
    end
  end
end
