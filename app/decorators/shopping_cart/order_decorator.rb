module ShoppingCart
  class OrderDecorator < Draper::Decorator
    include ActionView::Helpers::NumberHelper

    delegate_all
    decorates_association :billing_address
    decorates_association :shipping_address
    decorates_association :delivery
    decorates_association :credit_card
    decorates_association :order_items

    def sub_total
      number_to_currency(object.sub_total_price)
    end

    def shipping
      number_to_currency(object.shipping_price)
    end

    def total
      number_to_currency(object.total_price)
    end
  end
end