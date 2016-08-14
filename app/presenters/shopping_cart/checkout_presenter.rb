module ShoppingCart
  class CheckoutPresenter < Rectify::Presenter
    attribute :order, Order

    def address_title
      case current_path
        when addresses_order_path
          underlined_title(:address)
        else
          link_title(:address, addresses_order_path)
      end
    end

    def delivery_title
      case current_path
        when delivery_order_path
          underlined_title(:delivery)
        when addresses_order_path
          return link_title(:delivery, delivery_order_path) if delivery?
          simple_title(:delivery)
        else
          link_title(:delivery, delivery_order_path)
      end
    end

    def payment_title
      case current_path
        when payment_order_path
          underlined_title(:payment)
        when confirm_order_path
          link_title(:payment, payment_order_path)
        else
          return link_title(:payment, payment_order_path) if payment?
          simple_title(:payment)
      end
    end

    def confirm_title
      case current_path
        when confirm_order_path
          underlined_title(:confirm)
        else
          return link_title(:confirm, confirm_order_path) if confirm?
          simple_title(:confirm)
      end
    end

    def complete_title
      simple_title(:complete)
    end

    def sub_total
      order.sub_total
    end

    def total
      order.total_price
    end

    def shipping
      order.shipping_price
    end

    def price(name)
      number_to_currency(order.public_send(name))
    end

    private

    def current_path
      request.env['REQUEST_PATH']
    end

    def underlined_title(title)
      content_tag :li do
        content_tag :span, t(title), class: 'checkout-element underlined'
      end
    end

    def link_title(title, path)
      content_tag :li do
        link_to t(title), path, class: 'checkout-element',  "data-no-turbolink" => true
      end
    end

    def simple_title(title)
      content_tag :li do
        content_tag :span, t(title), class: 'checkout-element'
      end
    end

    def address?
      order.billing_address && order.shipping_address
    end

    def delivery?
      order.delivery
    end

    def payment?
      order.credit_card
    end

    def confirm?
      address? && delivery? && payment?
    end
  end
end