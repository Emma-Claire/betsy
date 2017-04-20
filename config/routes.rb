Rails.application.routes.draw do
  category_constraints = { category: /(Aquamarine)|(Green)|(Maroon)/}
  get 'products(/:category)', to: 'products#index', as: 'products', constraints: category_constraints
  get 'products/:id', to: 'products#show', as: 'product'

  get 'products/new', to: 'products#new', as: 'new_product'
  post 'products', to: 'products#create'

  get 'products/:id/edit', to: 'products#edit', as: 'edit_product'

  post 'products/:id/edit', to: 'products#edit'
  patch 'products/:id', to: 'products#update'
  resources :reviews, only: [:new, :create]
end
