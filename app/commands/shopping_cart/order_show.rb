module ShoppingCart
  class OrderShow < Rectify::Command

    def initialize(order)
      @order = order
    end

    def call
      broadcast(:wrong_order) if @order.in_progress?
    end
  end
end