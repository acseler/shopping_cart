module ShoppingCart
  class ApplicationController < ::ApplicationController
    helper ShoppingCart::Engine.helpers
    protect_from_forgery with: :exception

  end
end
