Rails.application.routes.draw do
  resources :reviews, only: [:new, :create]
end
