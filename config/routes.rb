Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  get "/" => 'static_pages#home'
  get "/dashboard" => 'static_pages#dashboard'

  root 'static_pages#home'

  resources :gardens
  resources :garden_produces
  resources :produces
end
