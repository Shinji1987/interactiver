Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :users, only: [:show, :edit, :update] do
    resources :friend_requests, only: [:index, :new, :create, :destroy]
  end
  resources :posts, only: [:index, :new, :create] do
    resources :comments, only: [:new, :create]
    resources :likes, only: [:create, :destroy]
  end
  post   '/like/:post_id' => 'likes#like',   as: 'like'
end