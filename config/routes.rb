Rails.application.routes.draw do
  # Devise routes
  devise_for :users

  # Main routes
  resources :properties

  # Custom route for archives
  get 'archives', action: :archives, controller: 'properties'

  resources :properties do
    member do
      post :archive
    end
  end

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

end
