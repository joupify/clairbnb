Rails.application.routes.draw do
  root to: 'static_pages#home'

  namespace :host do
    resources :listings do
      # /host/listings/:listing_id/rooms
      resources :rooms, only: [:index, :new, :create, :destroy] 
      end
  end

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

end
