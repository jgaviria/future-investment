Rails.application.routes.draw do
  devise_for :users
  resources :properties

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

end
