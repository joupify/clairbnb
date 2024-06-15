Rails.application.routes.draw do
  get 'webpush_subs/index'
  get 'messages/index'
  root to: 'static_pages#home'
  get 'static_pages/dashboard'


  resources :listings, only: [] do
    member do
      get :show_more_photos
    end
  end

  resources :webhooks, only: [:create]
  resources :webpush_subs

  resources :listings, only: [:index, :show] do
    resources :reservations  do
      resources :messages, only: [:index, :create, :new]
    end
  end

  post '/listings/:listing_id/reservations/:id/cancel', to: 'reservations#cancel', as: 'cancel_listing_reservation'
  get '/listings/:listing_id/reservations/:id/expire', to: 'reservations#expire', as: 'expire_listing_reservation'

  post '/webhooks/:source' => 'webhooks#create'
  get '/listings/search', to: 'listings#search'



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
      resources :reservations

      

    end
  end


  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Resque gem
  require 'resque/server'
  mount Resque::Server.new, at: '/jobs', as: 'public_resque'  # Unique name

  authenticate :user do
    mount Resque::Server, at: '/private_resque', as: 'private_resque'  # Unique name
  end
end
