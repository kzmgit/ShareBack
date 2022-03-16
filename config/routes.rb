Rails.application.routes.draw do

  root 'products#index'
  get '/about' => 'homes#about'
  get '/sign_up' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :users, except: [:new]
  resources :products do
    resources :feedbacks, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :tags, only: [:index, :show], param: :word
end
