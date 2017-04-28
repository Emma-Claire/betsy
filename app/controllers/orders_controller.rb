class OrdersController < ApplicationController
  before_action :place_order?, only: [:edit, :update]
  before_action :require_login, only: [:index, :show, :ship]

  def index
    @merchant = Merchant.find_by(id: params[:merchant_id])
    if @merchant.id != @current_user.id
      restrict_permission
    else
      @merchant_orders = @merchant.build_orders_hash
    end
  end

  def show
    @order = Order.find_by(id: params[:id])
    order_merchants = @order.products.map { |product| product.merchant.id}
    if !order_merchants.include? @current_user.id
      restrict_permission
    end
  end

  def edit
  end

  def update
      @order.update_attributes(order_params)
      if @order.save
        @order.modify_inventory("-")
        flash[:status] = :success
        flash[:result_text] = "Your order is complete!"
        if session[:order_id]
          session[:order_id] = nil
        end
        render :summary
      else
        flash[:status] = :failure
        flash.now[:result_text] = "Unable to place your order. Please try again."
        flash.now[:messages] = @order.errors.messages
        render :edit, status: :not_found
      end
  end

  def cancel_order
    @order = Order.find_by(id: params[:id])
    @order.status = "cancelled"
    if @order.save
      @order.modify_inventory("+")
      flash[:status] = :success
      flash[:result_text] = "Order successfully cancelled"
    else
      flash[:status] = :failure
      flash[:result_text] = "Unable to cancel order. Please contact customer service."
    end
    redirect_to products_path
  end

  def ship
    order = Order.find_by(id: params[:id])

    result = order.mark_ops_shipped(params[:merchant_id].to_i)
    order.status = "shipped" if order.all_shipped?

    if result && order.save
      flash[:status] = :success
      flash[:result_text] = "Order successfully marked as shipped."
    else
      flash[:status] = :failure
      flash[:result_text] = "Unable to ship order at this time."
    end
    redirect_to merchant_orders_path(params[:merchant_id])
  end

private
  def order_params
    params.require(:order).permit(:status, :email, :mailing_address, :name_on_cc, :cc_num, :cc_exp, :cc_csv, :zip_code)
  end

  def place_order?
    @order = Order.find(params[:id])
    restrict_permission if @order.status != "pending"
    problem_products = @order.verify_inventory
    if !problem_products.empty?
      flash[:status] = :failure
      flash[:result_text] = "There are not enough of the following products in stock: #{problem_products}"
      redirect_to orderedproducts_path
    end
  end
end
