module ShoppingCart
  class DeliveryDecorator < Draper::Decorator
    include ActionView::Helpers::NumberHelper

    delegate_all

    def delivery_title
      "#{object.company} #{object.option} + #{number_to_currency(object.price)}"
    end
  end
end