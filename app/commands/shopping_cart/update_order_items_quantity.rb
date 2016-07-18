module ShoppingCart
  class UpdateOrderItemsQuantity < BaseCommand

    def call
      validate_form(:update_fields, valid_quantity?)
    end

    private

    def update_fields
      form_order_items.each do |id, quantity|
        order.take_item(id: id).update(quantity: quantity)
      end
      check_coupon unless coupon.blank?
    end

    def check_coupon
      if coup = Coupon.find_by(code: coupon)
        order.coupon = coup
        order.save
        update_order_price
      end
    end

    def valid_quantity?
      form_order_items.each do |_id, quantity|
        return false if wrong_quantity?(quantity)
      end
      true
    end

    def form_order_items
      @form.quantity
    end

    def coupon
      @form.coupon
    end

    def wrong_quantity?(quantity)
      quantity.to_i <= 0
    end
  end
end