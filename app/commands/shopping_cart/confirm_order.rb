module ShoppingCart
  class ConfirmOrder < BaseCommand

    def name
      :confirm_order
    end

    private

    def confirm_order
      order_to_queue
      assign_new_order
    end

    def order_to_queue
      order.queue
      order.completed_date = Time.now
      order.save
    end

    def assign_new_order
      user.orders << Order.new
      user.save
    end
  end
end
