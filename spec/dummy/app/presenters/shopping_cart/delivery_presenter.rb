module ShoppingCart
  class DeliveryPresenter < Rectify::Presenter
    attribute :deliveries, Delivery::ActiveRecord_Relation
    attribute :order_delivery, Delivery

    def checked
      return delivery_id unless order_delivery
      order_delivery.id
    end

    private

    def delivery_id
      deliveries.first.id
    end
  end
end
