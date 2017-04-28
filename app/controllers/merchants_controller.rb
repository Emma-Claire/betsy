class MerchantsController < ApplicationController
  # before_action :require_login, only: [:show]

  def index
    @merchants = Merchant.all
  end

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
    @products = @merchant.products.select { |product| !product.retired && product.inventory > 0 }
    if @merchant.nil?
      head :not_found
    end
    # render :status => 404 unless @merchant
    # render_404 unless @merchant
  end

  def auth_callback
    auth_hash = request.env['omniauth.auth']

    user = Merchant.find_by(oauth_provider: params[:provider], oauth_uid: auth_hash['uid'])

    if user.nil?
      user = Merchant.from_github(auth_hash)

      if user.save
        session[:user_id] = user.id
        flash[:status] = :success
        flash[:result_text] = "Successfully logged in as user #{user.username} "
      else
        flash[:status] = :failure
        flash[:result_text] = "Could not log in"
        user.errors.messages.each do |field, problem|
          flash[:field] = problem.join(', ')
        end
      end
    else
      session[:user_id] = user.id
      flash[:status] = :success
      flash[:message] = "Welcome back, #{user.username}"
    end
    redirect_to products_path
  end

  def destroy
    session[:user_id] = nil
    flash[:logout] = 'You logged out'
    redirect_to products_path
  end

  def all_products
    lookup_user
    @merchant = Merchant.find_by(id: @current_user.id)
    puts ">>>>>>>>>>>>>>>>>> @merchant"
    render :all_products
  end

  private

  def merchant_params
    return params.require(:merchant).permit(:username, :email)
  end
end
