Rails.application.routes.draw do
  get 'chats/show'
  root 'homes#top'
  devise_for :users
  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'
  get 'aline' => 'alines#aline'
  resources :users,only: [:show,:index,:edit,:update] do
    member do
    get :search
    get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  resources :groups, only: [:new,:create, :show, :index, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
    resources :event_notices, only: [:new, :create]
    get "event_notices" => "event_notices#sent"
  end

  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]


end