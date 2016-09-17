module ShoppingCart
  class Country < ActiveRecord::Base
    validates :name, presence: true
  end
end
