module ShoppingCart
  class DeliveryForm < Rectify::Form
    attribute :delivery, Hash
    attribute :order, Order
  end
end