class ProductsController < ApplicationController

  def index
    @category = params[:category]
    @products = @category ? Product.where(category: @category) : Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    # @product.retired = false


    if @product.save
      redirect_to products_path
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])

    if @product.nil?
      head :not_found
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      head :not_found
    else
      @product.update_attributes(product_params)
      if @product.save
        redirect_to product_path(@product.id)
      else
        render :edit, status: :bad_request
      end
    end
  end

  private
  def product_params
    return params.require(:product).permit(:name, :price, :category, :description, :inventory, :photo_url, :retired)
  end
end
