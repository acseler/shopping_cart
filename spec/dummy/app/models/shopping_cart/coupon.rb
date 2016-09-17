module ShoppingCart
  class Coupon < ActiveRecord::Base
    has_one :order
    validates :per_cent, :code, presence: true, uniqueness: true
  end
end
