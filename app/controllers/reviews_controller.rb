class ReviewsController < ApplicationController
  def new
    #check products params
    # # if #current user and product.merchant_id == current user id
    #   redirect_to product_path(@product.id)
    # else
    @review = Review.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.product = @product

    if @review.save
      flash[:status] = :success
      flash[:result_text] = "Review successfully submitted"
      redirect_to product_path(@product.id)
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not create new review"
      flash[:messages] = @review.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    @review = Review.find_by(product_id: params[:product_id])
    if @review.nil?
      head :not_found
    end
  end

  private

  def review_params
    return params.require(:review).permit(:rating, :comment)
  end
end
