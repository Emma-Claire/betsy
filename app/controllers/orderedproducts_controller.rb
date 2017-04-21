class OrderedproductsController < ApplicationController

  def create
    find_order
    op = Orderedproduct.new(product_id: params[:product_id], order_id: @order.id, quantity: 1)
    if op.save #may change this
      flash[:success] = "Successfully added to cart"
    else
      flash[:failure] = "Unable to add item to cart"
    end
  end

  def edit
    find_order
    @op = Orderedproduct.find_by(orderedproduct_id: params[:orderedproduct_id], order_id: @order.id)

    if @op.nil?
      head :not_found
    end
  end

  private

  def start_new_order
    @order = Order.create(status: "pending")
    session[:order_id] = @order.id
  end

  def find_order
    @order = Order.find_by(id: session[:order_id])
    if @order.nil?
      start_new_order
    end
  end
end
