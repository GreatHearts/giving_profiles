Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'home/index'
  root 'home#login'
  get '/about' => 'home#about'
  get '/policy' => 'home#policy'
  get '/contact' => 'home#contact'
  get '/search' => 'search#index'

  resources :users, only: [:show, :edit, :update] do
    member do
      get :home
    end
  end
end
