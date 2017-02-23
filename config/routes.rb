Rails.application.routes.draw do
  resources :words
  root "pages#show", page: "home"

  get "/pages/*page", to: "pages#show"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/logout", to: "sessions#destroy"

  resources :users, except: :destroy
  resources :lessons, except: :destroy
  resources :categories, only: [:show, :index]

  namespace :admin do
    root "users#index"
    resources :users
    resources :categories do
      resources :words
    end
    resources :words
  end
end
