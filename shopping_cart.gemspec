$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'shopping_cart/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'shopping_cart'
  s.version     = ShoppingCart::VERSION
  s.authors     = ['acsler']
  s.email       = ['acsler@mail.ru']
  s.homepage    = 'https://github.com'
  s.summary     = 'ShoppingCart'
  s.description = 'Shopping cart engine'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.2.6'
  s.add_dependency 'aasm', '~> 4.11'
  s.add_dependency 'rectify'
  s.add_dependency 'draper', '~> 1.3'

  s.add_development_dependency 'pg'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-webkit', '~> 1.11'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'selenium-webdriver', '~> 2.53', '>= 2.53.3'
  s.add_development_dependency 'chromedriver-helper'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'devise'
  s.add_development_dependency 'haml-rails', '~> 0.9.0'

  s.test_files = Dir['spec/**/*']
end
