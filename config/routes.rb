Rails.application.routes.draw do
  root "pages#show", page: "home"

  get "/pages/*page", to: "pages#show"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/logout", to: "sessions#destroy"

  resources :users, expect: :destroy
  namespace :admin do
    get "/admin", to: "users#admin"
  end
  resources :categories, only: [:new, :create, :index]
end
