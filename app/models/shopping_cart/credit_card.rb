module ShoppingCart
  class CreditCard < ActiveRecord::Base
    has_one :order
    validates :number, :exp_month, :exp_year, :code, presence: true
  end
end
