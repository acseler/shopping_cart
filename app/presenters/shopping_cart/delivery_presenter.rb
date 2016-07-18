module ShoppingCart
  class DeliveryPresenter < Rectify::Presenter
    attribute :deliveries, Delivery::ActiveRecord_Relation
    attribute :order_delivery, Delivery

    def checked
      return deliveries.first.id unless order_delivery
      order_delivery.id
    end
  end
end