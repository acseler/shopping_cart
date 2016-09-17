module ShoppingCart
  class OrderItem < ActiveRecord::Base
    belongs_to :product, polymorphic: true
    belongs_to :order
    validates :price, :quantity, presence: true

    def self.take_item(attr)
      find_by(attr)
    end
  end
end
