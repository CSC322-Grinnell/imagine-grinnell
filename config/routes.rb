Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  get "/" => 'static_pages#home'
  get "/dashboard" => 'static_pages#dashboard'

  root 'static_pages#home'

  resources :gardens
  resources :garden_produces
  resources :produces
  resources :users, only: :create do
    collection do
      post 'login'
    end
  end
end
