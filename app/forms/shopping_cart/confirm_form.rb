module ShoppingCart
  class ConfirmForm < Rectify::Form
    attribute :order, Order
    attribute :customer, Customer
  end
end