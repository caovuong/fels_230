Rails.application.routes.draw do
  root "pages#show", page: "home"
  get "/pages/*page", to: "pages#show"
  resource :categories, only: [:new, :create]
end
