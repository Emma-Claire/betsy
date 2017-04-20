require "test_helper"

describe MerchantsController do
  describe "new" do
    it "succesfuly loads new_merchant_path" do
      get new_merchant_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "creates a new merchant" do
      start_count = Merchant.count

      merchant_data = {
        merchant: {
            username: "jamie",
            email: "jamie@domainname.org"
        }
      }
      post merchants_path, params: merchant_data
      must_redirect_to merchants_path
      end_count = Merchant.count
      end_count.must_equal start_count + 1

      merchant = Merchant.last
      merchant.username.must_equal merchant_data[:merchant][:username]
    end

    it "responds with bad_request for NG data" do
      start_count = Merchant.count

      merchant_data = {
        merchant: {
          foo: ""
        }
      }
      post merchants_path, params: merchant_data
      must_respond_with :bad_request

      end_count = Merchant.count
      end_count.must_equal start_count
    end
  end

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
