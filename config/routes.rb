Rails.application.routes.draw do
  root 'home#show'

  get '/auth/github/callback', to: 'sessions#create'
end
