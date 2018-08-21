Rails.application.routes.draw do
  root 'home#show'
  get '/auth/failure', to: redirect('/')
  get '/auth/github/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:show] do
    get '/recent_activity', to: 'recent_activity#show'
  end
end
