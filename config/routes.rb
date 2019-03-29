Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  get '/about' => 'home#about'

  resources :users, only: [:show, :edit]
end
