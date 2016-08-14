module ShoppingCart
  class CartViewsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def generate_views
      directory 'order_items', 'app/views/shopping_cart/order_steps/'
      directory 'orders', 'app/views/shopping_cart/orders/'
      directory 'presenters/', 'app/presenters/'
      copy_file 'customers_helper.rb', 'app/helpers/shopping_cart/customers_helper.rb'
    end
  end
end