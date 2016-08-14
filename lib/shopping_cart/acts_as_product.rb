module ShoppingCart
  module ActsAsShoppingCart
    extend ActiveSupport::Concern

    def included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def acts_as_product
        has_many :order_items, dependent: :delete_all,
                 class_name: 'ShoppingCart::OrderItem', as: :product
      end

      def acts_as_customer
        has_many :orders, dependent: :delete_all,
                 class_name: 'ShoppingCart::Order', as: :customer
        delegate :in_progress, to: :orders, prefix: true
        delegate :in_queue, to: :orders, prefix: true
        delegate :in_delivery, to: :orders, prefix: true
        delegate :delivered, to: :orders, prefix: true
      end
    end
  end
end
