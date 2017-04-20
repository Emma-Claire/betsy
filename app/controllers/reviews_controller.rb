class ReviewsController < ApplicationController
  def new
    @product = Product.find(params[:id])#check products params
    if #current user and product.merchant_id == current user id
      redirect_to product_path(@product.id)  #need to add alert "You must log in to do that"
    else
      @review = @product.Review.new
    end

  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to product_path(@review.product_id)
    else render :new
    end
  end

  private

  #do we need a product rating update method here, for the average rating??

  def review_params
    return params.permit(review: [:rating, :product_id])
  end
end

#should I include merchant ID in the params to generate error message if merchant tries to review own product and add private method
