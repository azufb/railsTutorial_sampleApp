Rails.application.routes.draw do
  root "static_pages#home"
  # 名前付きルーティングを定義
  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"
  get  "/contact", to: "static_pages#contact"
end
