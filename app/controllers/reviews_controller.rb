class ReviewsController < ApplicationController
  def new
    @product = Product.find(params[:id])#check products params
    # # if #current user and product.merchant_id == current user id
    #   redirect_to product_path(@product.id)
    # else
    @review = @product.Review.new
    # redirect_to product_path(@product.id)
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to root_path
    else render :new
    end

    def show
      @review = Review.find_by(product_id: params[:product_id])
    end
  end


  private

  def review_params
    return params.permit(review: [:rating, :product_id, :comment])
  end
end
