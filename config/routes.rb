Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :events
  root "events#index"
end
