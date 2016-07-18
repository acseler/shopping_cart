module ShoppingCart
  class ConfirmOrder < BaseCommand

    def name
      :confirm_order
    end

    private

    def confirm_order
      update_book_stock
      order_to_queue
      assign_new_order
    end

    def order_to_queue
      order.queue
      order.completed_date = Time.now
      order.save
    end

    def assign_new_order
      customer.orders << Order.new
      customer.save
    end

    def update_book_stock
      order.order_items.each do |item|
        item.update_book_stock
      end
    end
  end
end
