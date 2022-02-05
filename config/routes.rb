Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  root 'home#top'
  # get 'home/top'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
