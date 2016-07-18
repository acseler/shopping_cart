module ShoppingCart
  class OrderItemDecorator < Draper::Decorator
    include ActionView::Helpers::NumberHelper

    delegate_all

    def currency_price
      number_to_currency(object.price)
    end

    def price_total
      number_to_currency(object.price * object.quantity)
    end
  end
end