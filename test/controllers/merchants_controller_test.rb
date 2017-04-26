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

  describe "auth_callback" do
    it "Registers a new user" do
      start_count = Merchant.count
# build auth info for user not in database
    user = Merchant.new(
    {
      username: "test_user",
      email: "test@user.net",
      oauth_provider: "github",
      oauth_uid: 99999
    }
    )
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

    get auth_callback_path(:github)

    must_redirect_to products_path

    session[:user_id].must_equal Merchant.last.id, "Merchant not logged in"

      Merchant.count.must_equal start_count + 1
    end

    it "accepts a returning user" do
      start_count = Merchant.count
      user = merchants(:alice)
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
      get auth_callback_path(:github)

      must_redirect_to products_path

      session[:user_id].must_equal user.id, "Merchant not logged in"

      Merchant.count.must_equal start_count
    end

    it "rejects incomplete auth data" do

    end
  end

  describe "destroy (logged out)" do
    it "should get logout" do

    end
  end
end
