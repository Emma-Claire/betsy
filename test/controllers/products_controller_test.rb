require "test_helper"

describe ProductsController do

  CATEGORIES = %w(AirPlants
  TropicalPlants Succulents Cacti Herbs IndoorTrees Planters)
  INVALID_CATEGORIES = ["nope", "42", "", "  ", "Succulentstrailingtext"]

  describe "index" do
    it "succeeds for a real category with many products" do
      CATEGORIES.each do |category|
        Product.by_category(category).count.must_be :>, 0, "No #{category.pluralize} in the test fixtures"
        get products_path(category)
        must_respond_with :success
      end
    end

    it "succeeds for a real category with no products" do
      Product.destroy_all
      CATEGORIES.each do |category|
        get products_path(category)
        must_respond_with :success
      end
    end

    # case for no category => products list
    # case for fake category
  end

  describe "show" do
    it "shows a product that exists" do
      product = Product.first
      get product_path(product)
      must_respond_with :success
    end
  end

  describe "create" do

    it "adds a product to the database" do
      product_data = {
        product: {
          name: "Orchid",
          price: 25.99,
          category: "Exotic",
          description: "text here",
          inventory: 120,
          photo_url: "link",
          merchant_id: Merchant.first.id
        }
      }
      post products_path, params: product_data
      must_redirect_to products_path
    end

    it "re-renders the new product form if the product is invalid" do
      product_data = {
        product: {
          name: "Orchid",
          price: 25.99,
          category: "Exotic"
        }
      }
      post products_path, params: product_data
      must_respond_with :bad_request
    end
  end

  describe "new" do
    it "should get new" do
      get new_product_path
      value(response).must_be :success?
    end

  end

  describe "edit" do
    it "succeeds for an existent product ID" do
      get edit_product_path(Product.first)
      must_respond_with :success
    end

    it "renders 404 for a bogus product ID" do
      bogus_product_id = Product.last.id + 1
      get edit_product_path(bogus_product_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "succeeds for valid data and an extant work ID" do
      product = Product.first
      product_data = {
        product: {
          name: product.name + " addition"
        }
      }

      patch product_path(product), params: product_data
      must_redirect_to products_path(product)

      Product.find(product.id).name.must_equal product_data[:product][:name]
    end

    it "renders bad_request for bogus data" do
      product = Product.first
      product_data = {
        product: {
          name: ""
        }
      }

      patch product_path(product), params: product_data
      must_respond_with :not_found

      # Verify the DB was not modified
      Product.find(product.id).name.must_equal product.name
    end

    it "renders 404 not_found for a bogus product ID" do
      bogus_product_id = Product.last.id + 1
      get product_path(bogus_product_id)
      must_respond_with :not_found
    end
  end

  # describe "destroy" do
  #   it "succeeds for an extant product ID" do
  #     product_id = Product.first.id
  #
  #     delete product_path(product_id)
  #     must_redirect_to root_path
  #
  #     # The work should really be gone
  #     Product.find_by(id: product_id).must_be_nil
  #   end
  #
  #   it "renders 404 not_found and does not update the DB for a bogus work ID" do
  #     start_count = Product.count
  #
  #     bogus_product_id = Product.last.id + 1
  #     delete product_path(bogus_product_id)
  #     must_respond_with :not_found
  #
  #     Product.count.must_equal start_count
  #   end
  # end
end
