class OrderedproductsController < ApplicationController

# before_action :require_login, only: [:show]

  def index
    find_order
    @ops = Orderedproduct.where(order: @order)
    # @items
    # message = ""
    # @ops.each do |op|
    #   message += check_stock(op.product_id, op.quantity, op.product.name).to_s
    #   message += "\n"
    # end
    # if message.present?
    #   flash[:warning] = message
    # end
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
      flash[:status] = :success
      flash[:result_text] = "Successfully added #{Product.find_by(id: op.product_id).name} to cart"
    else
      flash[:status] = :failure
      flash[:result_text] = "Unable to add #{Product.find_by(id: op.product_id).name} to cart"
      flash[:messages] = @product.errors.messages
    end
    redirect_to orderedproducts_path
  end

  # def edit
  #   find_order
  #
  #   @op = Orderedproduct.find_by(id: params[:id], order_id: @order.id)
  #
  #   if @op.nil?
  #     head :not_found
  #   end
  # end

  def update
    find_order
    @op = Orderedproduct.find_by(id: params[:id], order_id: @order.id)
    @op.update_attributes(op_params)

    # if !@op.check_inventory
    #   flash[:failure] = "You may only add up to #{@op.product.inventory} of this item to your cart"
    if @op.save
      flash[:result_text] = "Successfully updated item quantity"
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
      flash[:result_text] = "Successfully deleted #{Product.find_by(id: ops.first.product_id).name} from cart"
      ops.destroy_all
      redirect_to orderedproducts_path
    end
  end

  # def ship
  #
  #   @order = Order.find_by(id: params[:id])
  #   @order.status = "shipped"
  #   if @order.save
  #     flash[:message] = "Order successfully marked as shipped."
  #   else
  #     flash[:message] = "Unable to ship order at this time"
  #   end
  #   redirect_to
  # end


  private

  # def check_stock(id, quantity, name)
  #   if !Product.in_stock?(id, quantity)
  #     "\n\nSorry! There are not enough #{name}'s' to fulfill your order."
  #   end
  # end

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

end
