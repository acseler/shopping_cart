class ShoppingCart::CartLocalesGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def generate_locales
    directory 'shopping_cart/', 'config/locales/shopping_cart'
  end
end
