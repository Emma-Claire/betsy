class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  # def new
  #   @order = Order.new(order_params)
  # end
  def show

  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find_by(id: params[:id])
    @order.update_attributes(order_params)
    if @order.save
      flash[:status] = :success
      flash[:result_text] = "Your order is complete (order id: #{@order_id})"
      if session[:order_id]
        session[:order_id] = nil
      end
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
    params.require(:order).permit(:status, :email, :mailing_address, :name_on_cc, :cc_num, :cc_exp, :cc_csv, :zip_code)
  end
end
