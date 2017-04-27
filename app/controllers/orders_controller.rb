class OrdersController < ApplicationController
  before_action

  def index
    orders = Merchant.find_by(id: params[:merchant_id]).find_orders
    # any way to move this logic into the model? -> add keys for paid, pending, and shipped
    @orders = orders.group_by { |order| order.status }
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def edit
      @order = Order.find(params[:id]) #edit had only had this line and an end in it
      problem_products = @order.verify_inventory
      if !problem_products.empty?
        flash[:message] = "There are not enough of the following products in stock: #{problem_products}"
        redirect_to orderedproducts_path
      else
        render :edit
      end

    # else
    #   flash.now[:status] = :failure
    #   flash.now[:result_text] = "There aren't enough #{@order_id.product.name} to fulfill your order."
    # end
  end

  def update
    @order = Order.find_by(id: params[:id])
    @order.update_attributes(order_params)
    if @order.save
      flash[:status] = :success
      flash[:result_text] = "Your order is complete!"
      if session[:order_id]
        session[:order_id] = nil
      end
      # need to update this path once we know where we want it to go
      redirect_to order_path
    else
      flash.now[:status] = :failure
      flash.now[:result_text] = "Could not update your order (order id: #{@order_id})"
      flash.now[:messages] = @order.errors.messages
      render :edit, status: :not_found
    end
  end

  def cancel_order
    @order = Order.find_by(id: params[:id])
    @order.status = "cancelled"
    if @order.save
      flash[:message] = "Order successfully cancelled"
    else
      flash[:message] = "Unable to cancel order.  Please contact customer service."
    end
    
    patch changes order status from paid to cancelled
  end

private
  def order_params
    params.require(:order).permit(:status, :email, :mailing_address, :name_on_cc, :cc_num, :cc_exp, :cc_csv, :zip_code)
  end

  def place_order?
    @order = Order.find(params[:id]) #edit had only had this line and an end in it
    problem_products = @order.verify_inventory
    if !problem_products.empty?
      flash[:message] = "There are not enough of the following products in stock: #{problem_products}"
      redirect_to orderedproducts_path
    end
  end
end
