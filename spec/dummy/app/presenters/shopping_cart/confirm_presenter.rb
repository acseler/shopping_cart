module ShoppingCart
  class ConfirmPresenter < Rectify::Presenter
    attribute :order, Order

    def items
      order.order_items
    end

    def name(type)
      order.send(type).full_name
    end

    def street(type)
      order.send(type).street
    end

    def city(type)
      order.send(type).city
    end

    def country(type)
      order.send(type).country.name
    end

    def phone(type)
      order.send(type).phone
    end

    def company
      order.delivery.company
    end

    def option
      order.delivery.option
    end

    def card_number
      order.credit_card.hide_card_number
    end

    def exp_date
      order.credit_card.exp_date
    end

    def sub_total
      t(:sub_total_template, sub_total: order.sub_total)
    end

    def shipping
      t(:shipping_template, shipping: order.shipping)
    end

    def total
      t(:order_total_template, total: order.total)
    end

    def order_id
      t(:order, order: order.id)
    end
  end
end