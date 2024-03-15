Rails.application.routes.draw do
  root to: 'static_pages#home'

  resources :listings, only: [:index, :show]

  namespace :host do
    resources :listings do
      resources :photos, only: [:index, :create, :destroy]
      resources :rooms, only: [:index, :new, :create, :destroy] 
    end
  end

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

end
