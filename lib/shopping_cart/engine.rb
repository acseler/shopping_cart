module ShoppingCart
  class Engine < ::Rails::Engine
    isolate_namespace ShoppingCart
    config.i18n.load_path += Dir[config.root.join('config', 'locales', '**/*.yml').to_s]
    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
