class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new(order_params)
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order.update_attributes(order_params)
    if @order.save
      flash[:status] = :success
      flash[:result_text] = "Successfully updated your order (order id: #{@order_id})"
      # need to update this path once we know where we want it to go
      redirect_to products_path
    else
      flash.now[:status] = :failure
      flash.now[:result_text] = "Could not update your order (order id: #{@order_id})"
      flash.now[:messages] = @order.errors.messages
      render :edit, status: :not_found
    end
  end

private
  def order_params
    params.require(:order).permit(:status)
  end
end
