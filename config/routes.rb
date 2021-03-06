Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'home/index'
  root 'home#login'
  get '/about' => 'home#about'
  get '/policy' => 'home#policy'
  get '/contact' => 'home#contact'
  get '/contact' => 'home#contact'
  get '/search' => 'search#index'
  get '/search/:query/organization' => 'search#organizations', :as => :organization_search_results
  get '/search/:query/user' => 'search#users', :as => :user_search_results

  resources :users, only: [:show, :edit, :update] do
    member do
      get :home
      post :add_donation
    end
  end
end
