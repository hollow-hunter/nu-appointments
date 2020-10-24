Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/login', to: 'devise/sessions#new'
    get '/register', to: 'devise/registrations#new'
  end
  resources :staffs
  resources :clients
  resources :appointments
  namespace :api do
    resources :staffs
    resources :clients do
      collection do
        get '/code/:code', to: 'clients#code', as: :code
      end
    end
    resources :appointments
  end
  root to: 'pages#index'
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_error'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
