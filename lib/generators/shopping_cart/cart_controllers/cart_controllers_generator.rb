module ShoppingCart
  class CartControllersGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def generate_controllers
      copy_file 'order_items_controller.rb', 'app/controllers/shopping_cart/order_items_controller.rb'
      copy_file 'orders_controller.rb', 'app/controllers/shopping_cart/orders_controller.rb'
      directory 'commands', 'app/commands'
      directory 'forms', 'app/forms'
    end
  end
end