Rails.application.routes.draw do
  devise_for :users
  mount ShoppingCart::Engine => '/cart'
  resources :orders, module: :shopping_cart, only: [] do
    member do
      get 'my_step', action: 'my_step_edit'
      post 'my_step', action: 'my_step'
    end
  end
  root 'home#index'
  resources :books, only: :index
  resources :magazines, only: :index
end
