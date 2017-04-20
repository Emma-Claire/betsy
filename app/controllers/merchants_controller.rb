class MerchantsController < ApplicationController

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      flash[:status] = :success
      flash[:result_text] = "Successfully created Merchant #{@merchant.username}"
      redirect_to merchants_path
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not create Merchant #{@merchant.username}"
      flash[:messages] = @merchant.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
    @merchant = Merchant.find_by(id: params[:id])
    if @merchant.nil?
      head :not_found
    end
    # render :status => 404 unless @merchant
    # render_404 unless @merchant
  end

  private

  def merchant_params
    return params.require(:merchant).permit(:username, :email)
  end
end
