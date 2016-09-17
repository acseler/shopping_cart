class ShoppingCart::CartFormsGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def generate_forms
    directory 'forms/', 'app/forms/'
  end
end
