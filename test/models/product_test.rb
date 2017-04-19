require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  describe "relations" do
    it "has a list of reviews" do
      aloe = products(:aloe)
      aloe.must_respond_to :reviews
      aloe.reviews.

    end

    it "has a list of orderedproducts" do

    end
  end
end
