module ShoppingCart
  class BaseDecorator < Draper::Decorator
    def full_name
      "#{object.first_name} #{object.last_name}"
    end

    def currency_price
      number_to_currency(object.price)
    end
  end
end