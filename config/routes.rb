Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  get "/" => 'static_pages#home'

  root 'static_pages#home'

  resources :gardens
  resources :garden_produces
  resources :produces
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  post 'signup', to: 'users#create', as: 'signup'
  post 'login', to: 'sessions#create', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
