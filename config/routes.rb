Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :admins, controller: 'admins', type: 'Admin', only: [:show]
  resources :teachers, controller: 'teachers', type: 'Teacher', only: [:show]
  resources :students, controller: 'students', type: 'Student', only: [:show]

  namespace :api do
    namespace :v1 do
      resources :courses, only: [:index]
      resources :semesters, only: [:index]
      get 'admins/:admin_id/courses/:id', to: 'admins#all_course_grades'
      get 'admins/:admin_id/semesters/:id', to: 'admins#enrollment_counts'
      resources :teachers, controller: 'teachers', type: 'Teacher', only: [:show]
      resources :students, controller: 'students', type: 'Student', only: [:show]
    end
  end

  root "welcome#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/join", to: "users#new"
  post "/join", to: "users#create"
end
