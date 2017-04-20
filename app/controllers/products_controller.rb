class ProductsController < ApplicationController
  def index
    @category = params[:category]
    @products = @category ? Product.where(category: @category) : Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
  end
end
