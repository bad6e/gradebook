Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :admins, controller: 'admins', type: 'Admin'
  resources :teachers, controller: 'teachers', type: 'Teacher'
  resources :students, controller: 'students', type: 'Student'

  root "welcome#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/join", to: "users#new"
  post "/join", to: "users#create"
end
