Rails.application.routes.draw do
  root to: 'static_pages#home'


  resources :webhooks, only: [:create]
  resources :listings, only: [:index, :show] do
    resources :reservations
  end

  namespace :host do
    resources :listings do
      resources :photos, only: [:index, :create, :destroy]
      resources :rooms, only: [:index, :new, :create, :destroy]
    end
  end

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  require 'resque/server'
  mount Resque::Server, at: '/jobs', as: 'public_resque'  # Unique name

  authenticate :user do
    mount Resque::Server, at: '/private_resque', as: 'private_resque'  # Unique name
  end
end
