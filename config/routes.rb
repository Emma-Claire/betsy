Rails.application.routes.draw do

  get 'merchants/new', to: 'merchants#new', as: 'new_merchant'
  post 'merchants', to: 'merchants#create'

  get 'merchants/:id', to: 'merchants#show', as: 'merchant'

  category_constraints = { category: /(Aquamarine)|(Green)|(Maroon)/}
  get 'products(/:category)', to: 'products#index', as: 'products', constraints: category_constraints
  get 'products/:id', to: 'products#show', as: 'product'
  get 'products/new', to: 'products#new', as: 'new_product'

  post 'products', to: 'products#create'

  get 'products/:id/edit', to: 'products#edit', as: 'edit_product'

  post 'products/:id/edit', to: 'products#edit'
  patch 'products/:id', to: 'products#update'
  resources :reviews, only: [:new, :create]

  get 'orders/:id/edit', to:'orders#edit', as: 'edit_animal'
  patch 'animals/:id', to: 'animals#update'

  # orderedproduct routes
  # get 'orderedproducts', to: 'orderedproducts#index', as: 'orderedproducts'

  post 'orderedproducts/:product_id', to: 'orderedproducts#create', as: 'add_OP'
end
