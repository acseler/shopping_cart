module ShoppingCart
  module AssignOrder
    extend ActiveSupport::Concern

    def included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def assign_order
        class_eval do
          helper ShoppingCart::CustomersHelper

          before_action :put_order

          def put_order
            @order = current_user.orders_in_progress.first_or_create if current_user
          end

          def cart
            ShoppingCart::Engine.routes.url_helpers
          end
        end
      end
    end
  end
end