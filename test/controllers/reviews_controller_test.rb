require "test_helper"

describe ReviewsController do

  describe "create" do
    it "adds a review to the database " do
      start_count = Review.count

      review_params= {

        rating: 3,
        comment: "great product",
        product_id: 3
      }

      post reviews_path, params: review_params
      must_redirect_to root_path

      start_count.must_equal start_count + 1

      Review.last.rating.must_equal review_params
    end


    # review = reviews(:rating1)
    # # review_params = {
    # #   review: {
    # #     rating: 3,
    # #     comment: "great product",
    # #     product_id: 3
    # #   }
    # # }
    # post reviews_path, params: review_params
    # must_redirect_to root_path


    it "re-renders the new review form if the review was not saved" do
      review_data = {
        review: {
          rating: 3,
          comment: "great product",
          product_id: Product.first.id
        }
      }
      post product_path, params: review_params
      must_respond_with :bad_request
    end
  end
end
