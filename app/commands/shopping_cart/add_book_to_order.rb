module ShoppingCart
  class AddBookToOrder < BaseCommand

    def name
      :add_book_to_order
    end

    private

    def add_book_to_order
      if order_item
        order_item.update(quantity: order_item.quantity + 1)
      else
        ShoppingCart::OrderItem.create(attr_except(:user))
      end
    end

    def order_item
      order.take_item(product_id: product_id, product_type: product_type)
    end

    def product_id
      @form.product_id
    end

    def product_type
      @form.product_type
    end
  end
end