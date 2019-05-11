Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get 'home/index'
  root 'home#login'
  get '/about' => 'home#about'
  get '/policy' => 'home#policy'

  resources :users, only: [:show, :edit]
end
