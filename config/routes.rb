Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root to: 'items#index'

  resources :users, only: [:index]
  resources :mypages, only: [:show, :index]
  resources :creditcards, only: [:new, :create, :edit, :update, :index, :show]
  resources :products
  resources :addresses , only: [:new, :create ]

  # 削除済商品へのアクセスした場合のエラー画面を表示するためのルーティング
  get 'not_found', to:'products#not_found'
  
  end
