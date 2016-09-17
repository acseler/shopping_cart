module ShoppingCart
  class CheckoutPresenter < Rectify::Presenter
    attribute :order, Order

    def checkout_title(checkout_path, title_symb)
      if current_path.eql?(checkout_path)
        underlined_title(title_symb)
      else
        return link_title(title_symb, checkout_path) if send("#{title_symb}?")
        simple_title(title_symb)
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
      request.original_fullpath
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

    def address?
      order.billing_address && order.shipping_address
    end

    def delivery?
      order.delivery
    end

    def payment?
      order.credit_card
    end

    def my_step?
      order.my_step
    end

    def confirm?
      address? && delivery? && payment? && my_step?
    end
  end
end