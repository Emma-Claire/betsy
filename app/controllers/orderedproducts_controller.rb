class OrderedproductsController < ApplicationController

# before_action :require_login, only: [:show]

  def index
    find_order
    @ops = Orderedproduct.where(order: @order)
    num_items_in_cart
  end

  def create
    find_order
    start_new_order if @order.nil?
    op = Orderedproduct.find_by(product_id: params[:product_id], order_id: @order.id)
    if op
      op.quantity += 1
    else
      op = Orderedproduct.new(product_id: params[:product_id], order_id: @order.id, quantity: 1)
    end
    if op.save #may change this
      flash[:success] = "Successfully added #{Product.find_by(id: op.product_id).name} to cart"
    else
      flash[:failure] = "Unable to add #{Product.find_by(id: op.product_id).name} to cart"
    end
    redirect_to orderedproducts_path#product_path(Product.find(params[:product_id]))
  end

  def edit
    find_order
    @op = Orderedproduct.find_by(id: params[:id], order_id: @order.id)

    if @op.nil?
      head :not_found
    end
  end

  def update
    find_order
    @op = Orderedproduct.find_by(id: params[:id], order_id: @order.id)
    @op.update_attributes(op_params)

    # if !@op.check_inventory
    #   flash[:failure] = "You may only add up to #{@op.product.inventory} of this item to your cart"
    if @op.save
      flash[:success] = "Successfully updated item"
      redirect_to orderedproducts_path
    else
      flash[:failure] = "Unable to add item to cart"
      flash[:message] = @op.errors.messages
      redirect_to orderedproducts_path
      #, status: :not_found  #redirect
    end
  end

  def destroy
    find_order
    ops = Orderedproduct.where(id: params[:id], order_id: @order.id)
    if ops.empty?
      head :not_found
    else
      flash[:success] = "Successfully deleted #{Product.find_by(id: ops.first.product_id).name} from cart"
      ops.destroy_all
      redirect_to orderedproducts_path
    end
  end

  private

  def op_params
    return params.require(:orderedproduct).permit(:quantity)
  end

  def start_new_order
    @order = Order.create(status: "pending")
    session[:order_id] = @order.id
  end

  def find_order
    # unless session[:user_id].nil?
      @order = Order.find_by(id: session[:order_id])
    # end
    # puts ">>>>>>>>>>>>>>>>>#{session[:order_id]}|| #{@order.id}"
    # if @order.nil?
    #   start_new_order
    # end
  end

  def num_items_in_cart
    @items = Orderedproduct.cart_quantity(session[:order_id])
  end
end
