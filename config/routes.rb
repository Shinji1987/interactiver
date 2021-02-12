Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :users, only: [:show, :edit, :update] do
    member do
      get 'search'
    end
    resources :friend_requests, only: [:index, :create, :destroy, :edit, :update, :reject] do
      member do
        delete 'reject'
        delete 'remove'
      end
    end
  end
  resources :posts, only: [:index, :new, :create] do
    resources :comments, only: [:new, :create]
    resources :likes, only: [:create, :destroy]
  end
  post   '/like/:post_id' => 'likes#like',   as: 'like'

  resources :chats, only: [:new, :create] do
    resources :messages, only: [:new, :create]
  end
  get "news/data"
  resources :footprints, only: :index
  
  resources :graphs, only: :index

  resources :securitys, only: [:new, :create, :destroy]
end