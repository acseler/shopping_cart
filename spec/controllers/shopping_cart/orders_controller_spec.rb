require 'rails_helper'

module ShoppingCart
  RSpec.describe ShoppingCart::OrdersController, type: :controller do

    routes { ShoppingCart::Engine.routes }

    before(:each) do
      sign_in(user, scope: :user)
    end

    let(:user) { customer.user }
    let(:customer) { FactoryGirl.create(:customer) }
    let(:order) { customer.order_in_proggress }
    let(:billing_address) { customer.billing_address
                                .attributes.merge(first_name: 'Vasya') }
    let(:shipping_address) { customer.shipping_address
                                 .attributes.merge(first_name: 'Petya') }
    let(:use_billing_address) { {check: '0'} }
    let(:params_addr) { {billing_address: billing_address,
                         shipping_address: shipping_address,
                         use_billing_address: use_billing_address
    } }
    let(:delivery) { Delivery.last }
    let(:params_delivery) { {delivery: {delivery_id: delivery.id}} }
    let(:params_payment) { FactoryGirl.attributes_for(:credit_card) }

    context 'GET#order_addresses_edit' do
      it 'renders order_addresses_edit template' do
        get :order_addresses_edit, id: order
        expect(response).to render_template :order_addresses_edit
      end

      it 'assigns presenter and address_presenter' do
        get :order_addresses_edit, id: order
        expect(assigns(:presenter)).not_to be_nil
        expect(assigns(:address_presenter)).not_to be_nil
      end
    end

    context 'PUT#order_addresses' do
      it 'updates billing address and shipping address' do
        put :order_addresses, params_addr.merge(id: order)
        ord = Order.find(order.id)
        expect(ord.billing_address).not_to be_nil
        expect(ord.shipping_address).not_to be_nil
      end
    end

    context 'GET#delivery_edit' do

      it 'renders delivery edit template' do
        get :delivery_edit, id: order
        expect(response).to render_template :delivery_edit
      end

      it 'assigns @delivery_presenter' do
        get :delivery_edit, id: order
        expect(assigns(:delivery_presenter)).not_to be_nil
      end
    end

    context 'PUT#delivery' do
      it 'assigns delivery for order' do
        put :delivery, params_delivery.merge(id: order)
        expect(Order.find(order.id).delivery).not_to be_nil
      end
    end

    context 'GET#payment_edit' do
      it 'assigns peyment presenter' do
        get :payment_edit, id: order
        expect(assigns(:payment_presenter)).not_to be_nil
      end

      it 'renders payment edit template' do
        get :payment_edit, id: order
        expect(response).to render_template :payment_edit
      end
    end

    context 'PUT#payment' do
      it 'assigns delivery to order' do
        expect(order.credit_card).to be_nil
        put :payment, params_payment.merge(id: order)
        expect(Order.find(order.id).credit_card).not_to be_nil
      end
    end

    context 'GET#confirm_edit' do
      it 'assigns confirm presenter' do
        get :confirm_edit, id: order
        expect(assigns(:confirm_presenter)).not_to be_nil
      end

      it 'renders confirm edit template' do
        order.credit_card = FactoryGirl.create(:credit_card)
        order.save
        get :confirm_edit, id: order
        expect(response).to render_template :confirm_edit
      end
    end

    context 'PUT#confirm' do
      it 'changes order state to in_queue and create empty order instead' do
        expect(order.in_progress?).to be_truthy
        expect { put :confirm, id: order }
            .to change(Customer.find(customer.id).orders, :count).by(1)
        expect(Order.find(order.id).in_queue?).to be_truthy
        expect(Customer.find(customer.id).order_in_proggress)
            .not_to eq Order.find(order.id)
      end
    end

    context 'GET#complete' do
      it 'assigns presenter and confirm presenter' do
        get :complete, id: order
        expect(assigns(:presenter)).not_to be_nil
        expect(assigns(:confirm_presenter)).not_to be_nil
      end

      it 'renders complete template' do
        order.credit_card = FactoryGirl.create(:credit_card)
        order.queue
        order.save
        customer.orders << Order.new
        get :complete, id: order
        expect(response).to render_template :complete
      end
    end

    context 'GET#index' do
      it 'renders index template' do
        get :index, id: customer
        expect(response).to render_template :index
      end

      it 'assigns presenter' do
        get :index, id: customer
        expect(assigns(:presenter)).not_to be_nil
      end
    end

    context 'GET#show' do

      it 'renders show template' do
        order.queue
        order.save
        get :show, id: order
        expect(response).to render_template :show
      end

      it 'assigns confirm presenter' do
        order.queue
        order.save
        get :show, id: order
        expect(assigns(:confirm_presenter)).not_to be_nil
      end
    end
  end
end