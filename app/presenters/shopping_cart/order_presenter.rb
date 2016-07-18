module ShoppingCart
  class OrderPresenter < Rectify::Presenter
    attribute :order, Order

    def item
      order.order_items.count
    end

    def items
      t(:item).pluralize(order.order_items.count)
    end

    def img(form)
      order_item(form).book.image.order.url
    end

    def book_title(form)
      order_item(form).book.title
    end

    def book(form)
      order_item(form).book
    end

    def book_desc(form)
      order_item(form).book.short_desc.truncate(100)
    end

    def price(form)
      order_item(form).book.price
    end

    def order_item(form)
      order.order_items.find(form.object.attributes['id'])
    end
  end
end