Rails.application.routes.draw do
  get 'home/index'
  root 'home#login'
  get '/about' => 'home#about'
  get '/policy' => 'home#policy'

  resources :users, only: [:show, :edit] do
    member do
      get :home
    end
  end
end
