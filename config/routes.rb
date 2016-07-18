ShoppingCart::Engine.routes.draw do
  resources :orders, only: [:index, :show] do
    member do
      get 'addresses', action: 'order_addresses_edit'
      get 'delivery', action: 'delivery_edit'
      get 'payment', action: 'payment_edit'
      get 'confirm', action: 'confirm_edit'
      get 'complete', action: 'complete'
      put 'addresses', action: 'order_addresses', as: 'address'
      put 'delivery', action: 'delivery'
      put 'payment', action: 'payment'
      put 'confirm', action: 'confirm', as: 'place'
    end
  end
  resources :order_items, only: [:create, :destroy] do
    collection do
      post 'add', action: 'create'
      get 'edit', action: 'edit'
      put 'update', action: 'update'
      delete 'delete', action: 'destroy_all'
    end
  end
end
