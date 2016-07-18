module ShoppingCart
  class OrdersHistoryPresenter < Rectify::Presenter
    attribute :customer, Customer

    def orders_empty?
      order.order_items.empty? && in_queue.empty? && in_delivery.empty? && delivered.empty?
    end

    def items_empty?
      order.order_items.empty?
    end

    def items
      order.order_items
    end

    def order
      customer.order_in_proggress.decorate
    end

    def sub_total
      t(:sub_total_template, sub_total: order.sub_total)
    end

    def in_queue
      customer.orders_in_queue.decorate
    end

    def in_delivery
      customer.orders_in_delivery.decorate
    end

    def delivered
      customer.orders_delivered.decorate
    end

    def empty_orders
      t(:you_have_no_orders)
    end

    def go_to_cart_link
      link_to(t(:go_to_cart),
              edit_order_items_path(order),
              class: 'btn btn-default')
    end
  end
end