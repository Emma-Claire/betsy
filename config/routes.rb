Rails.application.routes.draw do

root 'products#index_9'

category_constraints = {
  category: /(air)|(tropical)|(succulents)|(cacti)|(herbs)|(trees)|(planters)/
}

  resources :merchants, except: [:new, :destroy, :edit, :update] do
    get 'orders', to: 'orders#index'
    patch 'orders/:id/ship', to: 'orders#ship', as: 'ship_order'
  end

  get 'merchants/products/all', to:'merchants#all_products', as: 'all_products'

  get 'products(/:category)', to: 'products#index', as: 'products', constraints: category_constraints

  resources :products, except: [:index] do
    resources :reviews, only: [:new, :create, :show]
  end

  resources :orders, only: [:show, :edit, :update]

  patch 'orders/:id/cancelled', to: 'orders#cancel_order', as: 'cancel'

  resources :orderedproducts, only: [:index, :update, :destroy]

  post 'orderedproducts/:product_id', to: 'orderedproducts#create', as: 'add_orderedproduct'
  
  get "/auth/:provider/callback", to: "merchants#auth_callback", as: 'auth_callback'
  delete 'logout', to: 'merchants#destroy'
end
