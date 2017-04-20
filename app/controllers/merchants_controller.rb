class MerchantsController < ApplicationController
  # def index
  #   @merchants = Merchant.all
  # end

  def new
    @merchant = Merchant.new
  end

  def show
    @merchant = Merchant.find_by(id: params[:id])
    if @merchant.nil?
      head :not_found
    end
    # render :status => 404 unless @merchant
    # render_404 unless @merchant
  end
end
