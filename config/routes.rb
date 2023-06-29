Rails.application.routes.draw do
  root 'static_pages#top'  #rootとはサイトのトップ画面。スタート画面などを指す。
  get '/signup', to: 'users#new'
  resources :users # RESTfulなUsersリソースで必要となる全てのアクションも利用できる。
end
