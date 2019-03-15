Rails.application.routes.draw do
  get 'giving_profiles/index'
  get 'home/index'
  root 'home#index'
  get 'home/about'


  resources :users, only: [:show]
end
