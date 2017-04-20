Rails.application.routes.draw do
  get 'products(/:category)', to: 'products#index', as: 'products'
  get 'products/:id', to: 'products#show', as: 'product'
end
