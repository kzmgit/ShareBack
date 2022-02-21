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
  end
  # フィードバック投稿失敗でrenderを使ったときのリロードエラー対策
  get '/products/:id/feedbacks' => 'products#show'

end
