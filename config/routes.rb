Rails.application.routes.draw do
  resources :staffs
  namespace :api do
    resources :staffs
  end
  root to: 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
