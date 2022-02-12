Rails.application.routes.draw do

  root 'products#index'
  get '/about' => 'homes#about'

  resources :users
  get '/sign_up' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :products

end
