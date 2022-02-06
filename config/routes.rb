Rails.application.routes.draw do
  root 'home#top'
  get '/signup', to: 'users#new'
  resources :users
end
