Rails.application.routes.draw do
  root to: 'static_pages#home'


  resources :webhooks, only: [:create]

  resources :listings, only: [:index, :show] do
    resources :reservations 
      # member do
      # post '/cancel'=> 'reservations#cancel'
      # end
    
  end
  post '/listings/:listing_id/reservations/:id/cancel', to: 'reservations#cancel', as: 'cancel_listing_reservation'

  post '/webhooks/:source' => 'webhooks#create'

  namespace :host do
    resources :merchant_settings do
      collection do
        get 'connected' => 'merchant_settings#connected'
        get 'connect' => 'merchant_settings#connect'
      end
    end
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
