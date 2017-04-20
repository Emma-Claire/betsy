require "test_helper"

describe MerchantsController do
  describe "new" do
    it "succesfuly loads new_merchant_path" do
      get new_merchant_path
      must_respond_with :success
    end
  end

  # describe "create" do
  #
  # end

  describe "show" do
    it "succeeds for and existing merchant" do
      merchant_id = Merchant.first.id
      get merchant_path(merchant_id)
      must_respond_with :success
    end

    it "renders 404 not_found for a NG merchant" do
      ng_merchant_id = Merchant.last.id + 1
      get merchant_path(ng_merchant_id)
      must_respond_with :not_found
    end
  end
end

# If your controller action reads form data and creates a model object, you need at least 2 cases:
# The data was valid
# The data was bad and validations failed
