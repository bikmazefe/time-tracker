Rails.application.routes.draw do
  devise_for :users
  root "static#home"

  namespace :admin do
    resources :entries, only: [:index]
    resources :reports, only: [:index]
  end

  post "/entries/start", to: "entries#start", as: "start_entry"
  post "/entries/finish", to: "entries#finish", as: "finish"
  resources :entries, only: [:create, :destroy]

  get "/profile", to: "profile#index", as: "profile"
  get "/profile/calendar", to: "profile#calendar", as: "calendar"
end
