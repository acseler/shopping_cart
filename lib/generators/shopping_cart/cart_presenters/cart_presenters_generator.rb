class ShoppingCart::CartPresentersGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def generate_models
    directory 'presenters', 'app/presenters'
  end
end
