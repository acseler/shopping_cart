require 'rails_helper'

module ShoppingCart
  RSpec.describe ShoppingCart::OrderItemsController, type: :controller do

    routes { ShoppingCart::Engine.routes }

    before(:each) do
      sign_in(user, scope: :user)
    end

    let(:customer) { FactoryGirl.create(:customer) }
    let(:user) { customer.user }

    context 'POST#create' do
      let(:book) { FactoryGirl.create(:book) }
      let(:attributes) { FactoryGirl.attributes_for(:order_item, book_id: book) }

      it 'it add order_item' do
        request.env['HTTP_REFERER'] = root_path
        post :create, attributes.merge(current_user: user)
        expect(OrderItem.last.quantity).to eq attributes[:quantity]
        expect(flash).to be_blank
      end
    end

    context 'GET#edit' do
      it 'renders orders edit template' do
        get :edit
        expect(response).to render_template 'orders/edit'
      end
    end

    context 'PUT#update' do
      let(:quantity) { {quantity: {
          first.id => 111,
          last.id => 222
      }} }

      let(:first) { customer.order_in_proggress.order_items.first }
      let(:last) { customer.order_in_proggress.order_items.last }

      it 'updates order items quantity' do
        put :update, quantity
        expect(OrderItem.find(last.id).quantity).to eq 222
      end
    end

    context 'DELETE#destroy' do
      it 'deletes order item' do
        expect { delete :destroy, id: OrderItem.last.id }
            .to change(OrderItem, :count).by(-1)
      end
    end

    context 'DELETE#destroy_all' do
      let(:count_of_order_items) { customer.order_in_proggress.order_items.count }

      it 'clear order items' do
        expect { delete :destroy_all }
            .to change(OrderItem, :count).by(-count_of_order_items)
      end
    end
  end
end