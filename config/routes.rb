Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/lgoin', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy' 

  root 'home#top'
  get '/signup', to: 'users#new'
  resources :users
end
