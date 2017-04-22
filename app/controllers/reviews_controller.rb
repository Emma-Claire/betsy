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
      flash[:status] = :success
      flash[:result_text] = "Review successfully submitted"
      redirect_to products_path  #replace with nested route
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
    return params.permit(review: [:rating, :product_id, :comment])
  end
end
