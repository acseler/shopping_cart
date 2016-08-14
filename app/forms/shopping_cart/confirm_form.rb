module ShoppingCart
  class ConfirmForm < Rectify::Form
    attribute :order, Order
    attribute :user, User
  end
end