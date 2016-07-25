Rails.application.routes.draw do
  devise_for :users
  mount ShoppingCart::Engine => '/cart'
  root 'home#index'
  resources :books, only: [:index, :show]
  resources :customers, only: :edit
end
