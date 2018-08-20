Rails.application.routes.draw do
  root 'home#show'
  get '/auth/failure', to: redirect('/')
  get '/auth/github/callback', to: 'sessions#create'

  resources :users, only: [:show]
end
