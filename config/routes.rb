Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :blogs
  get '/blogs/byUser/:user_id', to: 'blogs#indexByUser', as: 'user_blogs'
  get '/blogs/byCategory/:category', to: 'blogs#indexByCategory', as: 'category'
  root 'blogs#index'
end
