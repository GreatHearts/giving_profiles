Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  get '/about' => 'home#about'
  get '/policy' => 'home#policy'

  resources :users, only: [:show, :edit]
end
