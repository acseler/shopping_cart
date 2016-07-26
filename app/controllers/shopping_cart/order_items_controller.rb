module ShoppingCart
  class OrderItemsController < ApplicationController
    load_and_authorize_resource
    after_action :update_order_price, only: [:create, :update, :destroy]

    def create
      @form = OrderItemForm.from_params(params)
      @form.order = @order
      action = redirect_to :back
      AddBookToOrder.call(@form) do
        on(:ok) { action }
        on(:invalid) { action }
      end
    end

    def edit
      @presenter = EditOrderPresenter.new(order: @order.decorate)
                       .attach_controller(self)
      render 'shopping_cart/orders/edit'
    end

    def update
      @form = OrderItemsForm.from_params(params)
      @form.order = @order
      action = redirect_to edit_order_items_path
      UpdateOrderItemsQuantity.call(@form) do
        on(:ok) { action }
        on(:invalid) { action }
      end
    end

    def destroy
      OrderItem.delete(params[:id])
      redirect_to edit_order_items_path
    end

    def destroy_all
      @order.order_items.delete_all
      redirect_to main_app.root_path
    end
  end
end