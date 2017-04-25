require "test_helper"

describe ReviewsController do
  describe "new" do
    it "loads new_review_path" do #should change this to test nested route
      get new_review_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "adds a review to the database " do
      start_count = Review.count


      review_params= {
        review: {
          rating: 3,
          comment: "great product",
          product_id: 3
        }
      }

      post product_product_id_reviews_path, params: review_params
      must_redirect_to product_path(product_id)

      start_count.must_equal start_count + 1

      Review.last.rating.must_equal review_params[:review][:rating]
    end

    it "responds with bad_request for bad data " do
      start_count = Review.count
      review_params= {
        review: {
          rating: "good"
        }
      }
      post reviews_path, params: review_params
      must_respond_with :bad_request

      end_count = Review.count
      end_count.must_equal start_count
    end
  end

  describe "show" do
    it "succeeds for an existing review (or reviewed product?)" do
      review_id = Review.first.id
      get reviews_path(review_id)
      must respond_with :success
    end

    it "renders 404 not found for a non-existing review" do
      bad_review_id = Review.last.id + 1
      get review_path(bad_review_id)
      must_respond_with :not_found
    end
  end
end
