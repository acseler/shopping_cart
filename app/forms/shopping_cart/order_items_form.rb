module ShoppingCart
  class OrderItemsForm < Rectify::Form
    attribute :quantity, Hash
    attribute :order, Order
    attribute :coupon, String
  end
end
