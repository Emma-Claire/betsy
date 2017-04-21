class ReviewsController < ApplicationController
  def new
     @product = Product.find(params[:id])#check products params
    # # if #current user and product.merchant_id == current user id
    #   redirect_to product_path(@product.id)
    # else
      @review = @product.Review.new
    end



  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to product_path(@review.product_id)
    else render :new
    end
  end

  private

  def review_params
    return params.permit(review: [:rating, :product_id])
  end
end
