Rails.application.routes.draw do
  get 'companies/new', to: 'companies#new'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get '/login', to: 'devise/sessions#new'
    get '/register', to: 'devise/registrations#new'
  end
  resources :staffs
  resources :clients
  resources :appointments do
    collection do
      get '/status', to: 'appointments#status', as: :status
    end
  end
  namespace :api do
    post 'invitations', to: 'invitations#create'
    resources :staffs
    resources :clients do
      collection do
        get '/code/:code', to: 'clients#code', as: :code
      end
    end
    resources :appointments
    resources :companies
  end
  root to: 'pages#index'
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_error'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
