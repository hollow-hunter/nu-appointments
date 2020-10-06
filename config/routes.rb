Rails.application.routes.draw do
  resources :staffs
  resources :clients
  resources :appointments
  namespace :api do
    resources :staffs
    resources :clients
    resources :appointments
  end
  root to: 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
