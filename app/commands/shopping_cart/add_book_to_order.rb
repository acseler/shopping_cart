module ShoppingCart
  class AddBookToOrder < BaseCommand

    def name
      :add_book_to_order
    end

    private

    def add_book_to_order
      if order_item
        order_item.update(quantity: quantity(order_item))
      else
        ShoppingCart::OrderItem.create(attr_except(:user))
      end
    end

    def order_item
      order.take_item(book_id: book_id)
    end

    def quantity(item)
      item.quantity + @form.quantity
    end

    def book_id
      @form.book_id
    end
  end
end