Rails.application.routes.draw do

root 'products#index'

category_constraints = {
  category: /(air)|(tropical)|(succulents)|(cacti)|(herbs)|(trees)|(planters)/
}
  # get 'merchants', to: 'merchants#index', as: 'merchants'
  # get 'merchants/new', to: 'merchants#new', as: 'new_merchant'
  # post 'merchants', to: 'merchants#create'
  # get 'merchants/:id', to: 'merchants#show', as: 'merchant'

  resources :merchants, except: [:destroy, :edit, :update] do
    get 'orders', to: 'orders#index'
    patch 'orders/:id/ship', to: 'orders#ship', as: 'ship_order'
  end

  get 'merchants/products/all', to:'merchants#all_products', as: 'all_products'

  get 'products(/:category)', to: 'products#index', as: 'products', constraints: category_constraints

  resources :products, except: [:index] do
    resources :reviews, only: [:new, :create, :show]
  end



  resources :orders, only: [:show, :edit, :update]
  #
  # get 'orders/:id', to: 'orders#show', as: 'order'
  # get 'orders/:id/edit', to: 'orders#edit', as: 'edit_order'
  # # post 'orders/:id/edit', to: 'orders#edit'
  # patch 'orders/:id', to: 'orders#update'
  patch 'orders/:id/cancelled', to: 'orders#cancel_order', as: 'cancel'

  resources :orderedproducts, only: [:index, :update, :destroy]
  # get 'orderedproducts', to: 'orderedproducts#index', as: 'orderedproducts'
  #
  post 'orderedproducts/:product_id', to: 'orderedproducts#create', as: 'add_orderedproduct'
  #
  # patch 'orderedproducts/:id', to: 'orderedproducts#update', as: 'orderedproduct'
  # delete 'orderedproducts/:id', to: 'orderedproducts#destroy'


  get "/auth/:provider/callback", to: "merchants#auth_callback", as: 'auth_callback'
  delete 'logout', to: 'merchants#destroy'
end
