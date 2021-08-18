Rails.application.routes.draw do
  devise_for :users
  root "static#home"

  namespace :admin do
    resources :entries, only: [:index]
    resources :reports, only: [:index]
  end

  post "/entries/start", to: "entries#start", as: "start_entry"
  resources :entries, only: [:create] do
    member do
      post "/finish", to: "entries#finish", as: "finish"
    end
  end

  get "/profile", to: "profile#index", as: "profile"
end
