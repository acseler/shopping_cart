require 'rails_helper'

module ShoppingCart
  RSpec.describe ShoppingCart::OrdersController, type: :controller do

    routes { ShoppingCart::Engine.routes }

    let(:user) { FactoryGirl.create(:user) }
    let(:order) { user.orders_in_progress.first }
    let(:billing_address) { FactoryGirl.create(:address) }
    let(:shipping_address) { FactoryGirl.create(:address) }
    let(:use_billing_address) { {check: '0'} }
    let(:params_addr) { {billing_address: billing_address.attributes,
                         shipping_address: shipping_address.attributes,
                         use_billing_address: use_billing_address
    } }
    let(:delivery) { Delivery.last }
    let(:params_delivery) { {delivery: {delivery_id: delivery.id}} }
    let(:params_payment) { FactoryGirl.attributes_for(:credit_card) }

    context 'GET#order_addresses_edit' do
      it 'renders order_addresses_edit template' do
        sign_in_user
        get :order_addresses_edit, id: order
        expect(response).to render_template :order_addresses_edit
      end

      it 'assigns presenter and address_presenter' do
        sign_in_user
        get :order_addresses_edit, id: order
        expect(assigns(:presenter)).not_to be_nil
        expect(assigns(:address_presenter)).not_to be_nil
      end

      it_behaves_like 'user not authorized' do
        let(:action) { get :order_addresses_edit, id: order }
      end
    end

    context 'PUT#order_addresses' do
      it 'updates billing address and shipping address' do
        sign_in_user
        put :order_addresses, params_addr.merge(id: order)
        ord = Order.find(order.id)
        expect(ord.billing_address).not_to be_nil
        expect(ord.shipping_address).not_to be_nil
      end

      it_behaves_like 'user not authorized' do
        let(:action) { put :order_addresses, params_addr.merge(id: order) }
      end
    end

    context 'GET#delivery_edit' do
      it 'renders delivery edit template' do
        sign_in_user
        get :delivery_edit, id: order
        expect(response).to render_template :delivery_edit
      end

      it 'assigns @delivery_presenter' do
        sign_in_user
        get :delivery_edit, id: order
        expect(assigns(:delivery_presenter)).not_to be_nil
      end

      it_behaves_like 'user not authorized' do
        let(:action) { get :delivery_edit, id: order }
      end
    end

    context 'PUT#delivery' do
      it 'assigns delivery for order' do
        sign_in_user
        put :delivery, params_delivery.merge(id: order)
        expect(Order.find(order.id).delivery).not_to be_nil
      end

      it_behaves_like 'user not authorized' do
        let(:action) { put :delivery,
                           {delivery: {delivery_id: 1}}.merge(id: order) }
      end
    end

    context 'GET#payment_edit' do
      it 'assigns peyment presenter' do
        sign_in_user
        get :payment_edit, id: order
        expect(assigns(:payment_presenter)).not_to be_nil
      end

      it 'renders payment edit template' do
        sign_in_user
        get :payment_edit, id: order
        expect(response).to render_template :payment_edit
      end

      it_behaves_like 'user not authorized' do
        let(:action) { get :payment_edit, id: order }
      end
    end

    context 'PUT#payment' do
      it 'assigns delivery to order' do
        sign_in_user
        expect(order.credit_card).to be_nil
        put :payment, params_payment.merge(id: order)
        expect(Order.find(order.id).credit_card).not_to be_nil
      end

      it_behaves_like 'user not authorized' do
        let(:action) { put :payment, params_payment.merge(id: order) }
      end
    end

    context 'GET#confirm_edit' do
      it 'assigns confirm presenter' do
        sign_in_user
        get :confirm_edit, id: order
        expect(assigns(:confirm_presenter)).not_to be_nil
      end

      it 'renders confirm edit template' do
        sign_in_user
        order.credit_card = FactoryGirl.create(:credit_card)
        order.save
        get :confirm_edit, id: order
        expect(response).to render_template :confirm_edit
      end

      it_behaves_like 'user not authorized' do
        let(:action) { get :confirm_edit, id: order }
      end
    end

    context 'PUT#confirm' do
      it 'changes order state to in_queue and create empty order instead' do
        sign_in_user
        expect(order.in_progress?).to be_truthy
        expect { put :confirm, id: order }
            .to change(User.find(user.id).orders, :count).by(1)
        expect(ShoppingCart::Order.find(order.id).in_queue?).to be_truthy
        expect(User.find(user.id).orders_in_progress.first)
            .not_to eq ShoppingCart::Order.find(order.id)
      end

      it_behaves_like 'user not authorized' do
        let(:action) { put :confirm, id: order }
      end
    end

    context 'GET#complete' do
      it 'assigns presenter and confirm presenter' do
        sign_in_user
        get :complete, id: order
        expect(assigns(:presenter)).not_to be_nil
        expect(assigns(:confirm_presenter)).not_to be_nil
      end

      it 'renders complete template' do
        sign_in_user
        order.credit_card = FactoryGirl.create(:credit_card)
        order.queue
        order.save
        user.orders << ShoppingCart::Order.new
        get :complete, id: order
        expect(response).to render_template :complete
      end

      it_behaves_like 'user not authorized' do
        let(:action) { get :complete, id: order }
      end
    end
  end
end