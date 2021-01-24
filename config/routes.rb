Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :users, only: [:show, :edit, :update]
  resources :posts, only: [:index, :new, :create] do
    resources :comments, only: [:new, :create]
    resources :likes, only: [:create, :destroy]
  end
  post   '/like/:post_id' => 'likes#like',   as: 'like'
end