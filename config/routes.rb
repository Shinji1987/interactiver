Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :users, only: [:new, :create]
  resources :posts, only: :index
  # get 'users', :to => 'users#create'
end