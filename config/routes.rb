# frozen_string_literal: true

Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :blogs
  get '/blogs/by_user/:user_id', to: 'blogs#index_by_user', as: 'user_blogs'
  get '/blogs/by_category/:category', to: 'blogs#index_by_category', as: 'category'
  root 'blogs#index'
end
