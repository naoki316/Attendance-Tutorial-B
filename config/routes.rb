Rails.application.routes.draw do
  root 'static_pages#top'  #rootとはサイトのトップ画面。スタート画面などを指す。
  get '/signup', to: 'users#new'
  
  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do # RESTfulなUsersリソースで必要となる全てのアクションも利用できる。
   member do
     get 'edit_basic_info'
     patch 'update_basic_info'
     get 'attendances/edit_one_month'
     patch 'attendances/update_one_month'
   end
   resources :attendances, only: :update
  end
end
