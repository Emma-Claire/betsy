require 'test_helper'

describe Review do
  let(:bad_review) { Review.create }
  let(:float_rating) { Review.create(rating: 0.1) }
  let(:negative_review) { Review.create(rating: -0.1) }
  let(:larger_review) { Review.create(rating: 6) }

  describe "relationship with products" do
    it "One review belongs to a product" do
      reviews(:rating1).must_respond_to :product
      reviews(:rating1).product.must_be_kind_of Product
    end
  end

  describe "Validations" do
    it "A review must have a rate in order to be created" do
      bad_review.valid?.must_equal false
    end

    it "Rating must be an integer" do
      float_rating.valid?.must_equal false
    end

    it "Rating must be greater_than 0" do
      negative_review.valid?.must_equal false
    end

    it "Rating must be less than 6" do
      larger_review.valid?.must_equal false
    end    
  end
end
