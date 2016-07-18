module ShoppingCart
  class ChooseDelivery < BaseCommand

    def name
      :assign_delivery
    end

    private

    def assign_delivery
      order.delivery_id = delivey_id
      order.shipping_price = delivery_price
      order.calculate_total
      order.save
    end

    def delivey_id
      @form.delivery['delivery_id']
    end

    def delivery_price
      Delivery.find(delivey_id).price
    end
  end
end