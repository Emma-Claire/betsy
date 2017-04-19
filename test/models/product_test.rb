require 'test_helper'

class ProductTest < ActiveSupport::TestCase
 describe "relations" do
   let (:product) {Product.new}

   it "has a list of reviews" do
     aloe = products(:aloe)
     aloe.must_respond_to :reviews
     aloe.reviews.each do |review|
       review.must_be_kind_of Review
     end
   end

   it "has a list of orderedproducts" do
     aloe = products(:aloe)
     aloe.must_respond_to :orderedproducts
     aloe.orderedproducts.each do |orderedproduct|
       orderedproduct.must_be_kind_of Orderedproduct
    end
   end

   it "has a merchant" do
     aloe = products(:aloe)
     aloe.must_respond_to :merchant
     aloe.merchant.must_be_kind_of Merchant
   end

   it "can set the merchant through 'merchant'" do
     product.merchant = merchants(:alice)
     product.merchant_id.must_equal merchants(:alice).id

   end

   it "can set the merchant through 'merchant_id'" do
     product.merchant_id = merchants(:alice).id
     product.merchant.must_equal merchants(:alice)
   end
 end

 describe "validations" do
   it "can be created with all attributes" do
     Product.create!(
      name: "test plant",
      price: 3.20,
      category: "succulent",
      description: "test test test",
      inventory: 10,
      photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMrYWIBguxOFvrI9AHqHm0vZlWdyO47DjQvHO2effL0DzJFQ2_PR9X9LQ",
      merchant: merchants(:alice)
     )
   end

   it "requires a name" do
     product = Product.new
     product.valid?.must_be false
     product.errors.messages.must_include :name
   end

   it "requires a unique name" do
     
   end

   it "requires a price" do
     product = Product.new
     product.valid?.must_be false
     product.errors.messages.must_include :price
   end
 end
end
