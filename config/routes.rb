Rails.application.routes.draw do
  resources :alerts
  resources :users
  resources :authentications
  root to: "authentications#new"
  delete '/logout' => 'authentications#destroy'
  get '/logout' => 'authentications#destroy'
end