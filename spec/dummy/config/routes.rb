Rails.application.routes.draw do
  devise_for :users
  mount ShoppingCart::Engine => '/cart'
  root 'home#index'
  resources :books, only: :index
  resources :customers, only: :edit
end
