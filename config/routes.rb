Rails.application.routes.draw do

  get 'merchants/new', to: 'merchants#new', as: 'new_merchant'

  get 'merchants/:id', to: 'merchants#show', as: 'merchant'
end
