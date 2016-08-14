module ShoppingCart
  class OrderItemForm < Rectify::Form
    attribute :price, Float
    attribute :product_id, Fixnum
    attribute :product_type, String
    attribute :order, Order

    validates :price, :product_id, :product_type, presence: true
  end
end