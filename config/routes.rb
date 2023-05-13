Rails.application.routes.draw do
  root "static_pages#home"
  # 名前付きルーティングを定義
  # asオプションで変更も可能
  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"
  get  "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # 名前付きルーティング・RESTfulなUsersリソースで必要な全てのアクションが利用できるようになる
  resources :users
  # editアクションへの名前付きルーティング
  resources :account_activations, only: [:edit]

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :microposts, only: [:create, :destroy]
  get '/microposts', to: 'static_pages#home'
end
