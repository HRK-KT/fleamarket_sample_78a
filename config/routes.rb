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
  resources :creditcards, only: [:new, :create, :edit, :update] 

  resources :products, only: [:show, :new, :create, :index, :update] 
  resources :addresses , only: [:new, :create ]
  end
