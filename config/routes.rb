Rails.application.routes.draw do
  resources :expert_ratings
  resources :images
  resources :tasks
  resources :themes
  resources :users
  resources :expert_ratings, only: [:create]
  get "main/index"
  get "main/help"
  get "main/contacts"
  get "main/about"
  get 'work', to: 'work#index'
  get 'choose_theme', to: 'work#choose_theme'
  post 'display_theme', to: 'work#display_theme'
  namespace :api do
    get 'next_image', to: 'api#next_image'
    get 'prev_image', to: 'api#prev_image'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "main#index"
end
