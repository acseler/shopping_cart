module ShoppingCart
  class OrdersController < ApplicationController
    load_and_authorize_resource
    before_action :assign_presenter, except: [:order_addresses,
                                              :delivery,
                                              :payment,
                                              :confirm,
                                              :complete,
                                              :index]
    before_action :check_order_items, except: [:complete, :index, :show]
    before_filter :assign_previous_order, only: [:complete, :show]

    def order_addresses_edit
      @address_presenter = AddressPresenter.new(countries: Country.all,
                                                customer: customer,
                                                order: @order
      ).attach_controller(self)
    end

    def delivery_edit
      redirect_to addresses_order_path @order if @order.billing_address.nil?
      @delivery_presenter = DeliveryPresenter.new(deliveries: Delivery.all.decorate,
                                                  order_delivery: @order.delivery
      ).attach_controller(self)
    end

    def payment_edit
      redirect_to delivery_order_path @order if @order.delivery.nil?
      credit_card = @order.credit_card || CreditCard.new
      @payment_presenter = PaymentPresenter.new(credit_card: credit_card)
                               .attach_controller(self)
    end

    def confirm_edit
      redirect_to payment_order_path @order if @order.credit_card.nil?
      @confirm_presenter = ConfirmPresenter.new(order: @order.decorate)
                               .attach_controller(self)
    end

    def complete
      redirect_to confirm_order_path @prev_order unless @prev_order.in_queue?
      @confirm_presenter = ConfirmPresenter.new(order: @prev_order)
                               .attach_controller(self)
      @presenter = CheckoutPresenter.new(order: @prev_order.decorate)
    end

    def order_addresses
      @form = OrderAddressesForm.from_params(params)
      @form.order = @order
      UpdateOrderAddresses.call(@form) do
        on(:ok) { redirect_to delivery_order_path }
        on(:invalid) { redirect_to addresses_order_path }
      end
    end

    def delivery
      @form = DeliveryForm.from_params(params)
      @form.order = @order
      ChooseDelivery.call(@form) do
        on(:ok) { redirect_to payment_order_path }
      end
    end

    def payment
      form = CreditCardForm.from_params(params)
      form.order = @order
      AddCreditCard.call(form) do
        on(:ok) { redirect_to confirm_order_path }
        on(:invalid) { redirect_to payment_order_path }
      end
    end

    def confirm
      order = @order
      form = ConfirmForm.new(order: order, customer: customer)
      ConfirmOrder.call(form) do
        on(:ok) { redirect_to complete_order_path order }
      end
    end

    def index
      @presenter = OrdersHistoryPresenter.new(customer: customer)
                       .attach_controller(self)
    end

    def show
      OrderShow.call(@prev_order) do
        on(:wrong_order) { redirect_to orders_path }
      end
      @confirm_presenter = ConfirmPresenter.new(order: @prev_order)
    end

    private

    def assign_presenter
      @presenter = CheckoutPresenter.new(order: @order.try(:decorate))
                       .attach_controller(self)
    end

    def check_order_items
      redirect_to main_app.root_path if @order.order_items.blank?
    end

    def assign_previous_order
      @prev_order = Order.find(params[:id]).decorate
    end
  end
end