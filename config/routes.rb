Rails.application.routes.draw do
  resources :gyms
  resources :workouts
  resources :exercises
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
