Rails.application.routes.draw do
  resources :gyms
  resources :workouts do
    resources :comments, only: [:new, :create, :index, :destroy]
  end
  resources :exercises
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :friendships

  get "signup", to: "users#new", as: "signup"
  get '/login', to: 'sessions#new', as: "login"
  post '/login', to: 'sessions#create', as: "sessions"
  post '/logout', to: 'sessions#destroy', as: "logout"

  get "/", to: "users#home", as: "root"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
