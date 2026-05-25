Rails.application.routes.draw do
  scope "(:locale)", locale: /ru|en/ do
    root "main#index"

    get "signup", to: "users#new"
    get "signin", to: "sessions#new"
    post "signin", to: "sessions#create"
    delete "signout", to: "sessions#destroy"

    get "help", to: "main#help", as: :help
    get "contacts", to: "main#contacts", as: :contacts
    get "about", to: "main#about", as: :about

    resources :users
    resources :themes
    resources :tasks
    resources :images
    resources :expert_ratings

    get "main/index"
    get "main/help"
    get "main/contacts"
    get "main/about"

    get "work", to: "work#index"
    get "choose_theme", to: "work#choose_theme"
    post "display_theme", to: "work#display_theme"

    namespace :api do
      get "next_image", to: "api#next_image"
      get "prev_image", to: "api#prev_image"
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
