Rails.application.routes.draw do
  resources :staffs
  resources :clients
  namespace :api do
    resources :staffs
    resources :clients
  end
  root to: 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
