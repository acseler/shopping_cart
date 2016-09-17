module ShoppingCart
  class Address < ActiveRecord::Base
    belongs_to :country, :class_name => 'ShoppingCart::Country'
  end
end
