Rails.application.routes.draw do
  root "events#index"

  devise_for :users
  resources :users
  resources :events do
    member do
      get 'rsvp'
      get 'cancel_rsvp'
    end
  end
end
