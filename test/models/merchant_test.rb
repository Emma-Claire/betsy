require 'test_helper'

describe Merchant do

  describe "validations" do
    it "Can be created with all attributes" do
      Merchant.create!(username: 'jamie', email: 'jamie@domainname.org')
    end

    it "requires a username" do
      merchant = Merchant.new
      merchant.valid?.must_equal false
      merchant.errors.messages.must_include :username
    end

    it "requires a unique username" do
      merchants(:alice)
      merchant_bad = Merchant.new(username: "alice")
      merchant_bad.valid?.must_equal false
    end

    it "requires a email" do #success case
      merchant = Merchant.new
      merchant.valid?.must_equal false
      merchant.errors.messages.must_include :email
    end

    it "requires a unique email" do #failure case
      merchants(:alice)
      merchant_bad = Merchant.new(email: "alice@domainname.org")
      merchant_bad.valid?.must_equal false
    end
  end

  describe "relations"do
    it "has a list of products" do
      sally = merchants(:sally)
      sally.must_respond_to :products
      sally.products.each do |product|
        product.must_be_kind_of Product
      end
    end
  end
end
