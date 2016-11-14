Rails.application.routes.draw do
  root 'users#index'

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/join", to: "users#new"
  post "/join", to: "users#create"
end
