Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  resources :users, only: [:show]
end
