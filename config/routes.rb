Rails.application.routes.draw do
  root 'static_pages#top'  #rootとはサイトのトップ画面。スタート画面などを指す。
  get '/signup', to: 'users#new'
  
  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users # RESTfulなUsersリソースで必要となる全てのアクションも利用できる。
end
