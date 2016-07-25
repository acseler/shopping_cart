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
          simple_title(:payment)
      end
    end

    def confirm_title
      case current_path
        when confirm_order_path
          underlined_title(:confirm)
        else
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
      number_to_currency(order.send(name))
    end

    private

    def current_path
      "/cart#{request.env['PATH_INFO']}"
    end

    def underlined_title(title)
      content_tag :li do
        content_tag :span, t(title), class: 'checkout-element underlined'
      end
    end

    def link_title(title, path)
      content_tag :li do
        link_to t(title), path, class: 'checkout-element', "data-no-turbolink" => true
      end
    end

    def simple_title(title)
      content_tag :li do
        content_tag :span, t(title), class: 'checkout-element'
      end
    end
  end
end