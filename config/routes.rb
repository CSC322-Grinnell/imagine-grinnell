Rails.application.routes.draw do

  resources :crops
  resources :volunteers
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  get "/" => 'static_pages#home'
  get "/dashboard" => 'static_pages#dashboard'

  root 'static_pages#home'

  resources :gardens
  resources :garden_produces
  resources :produces
  resources :users
  resources :sessions, only: [:new, :create, :destroy, :get]

  post 'signup', to: 'users#create', as: 'signup'
  post 'login', to: 'sessions#create', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'current_user', to: 'sessions#show', as: 'current_user'
end
