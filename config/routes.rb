Rails.application.routes.draw do
  # Devise routes
  devise_for :users

  # Entry point to the app
  root 'properties#index'

  # Main routes
  resources :properties

  # Custom route for archives
  get 'archives', action: :archives, controller: 'properties'

  resources :properties do
    member do
      post :archive
      post :activate
    end
  end

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

end
