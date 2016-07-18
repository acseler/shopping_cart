module ShoppingCart
  class Delivery < ActiveRecord::Base
    validates :company, :option, :price, presence: true
  end
end
