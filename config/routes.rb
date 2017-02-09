Rails.application.routes.draw do
  root "pages#show", page: "home"
  get "/pages/*page", to: "pages#show"

  resources :categories
end
