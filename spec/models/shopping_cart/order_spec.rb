require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:states) { %i(in_progress
                    in_queue
                    in_delivery
                    delivered
                    canceled ) }
  let(:order) { FactoryGirl.create(:order, total_price: 0) }
  let(:total) { order.sub_total_price + order.shipping_price }
  let(:coupon) { FactoryGirl.create(:coupon, per_cent: 10) }
  let(:coupon_sub_total) { order.sub_total_price * (100 - 10) / 100 }
  let(:coupon_total) { coupon_sub_total + order.shipping_price }

  %i(
    total_price
    sub_total_price
    shipping_price
    completed_date
    state
    billing_address_id
    shipping_address_id
  ).each do |symb|
    it { should have_db_column(symb) }
  end

  %i(billing_address shipping_address delivery customer).each do |symb|
    it { should belong_to(symb) }
  end

  it { should have_many(:order_items) }
  it { should validate_inclusion_of(:state).in_array(states) }

  it 'has valid factory' do
    expect(FactoryGirl.build(:order)).to be_valid
  end

  it 'calculate total price' do
    expect(order.total_price).to eq 0.0
    order.calculate_total
    expect(order.total_price).to eq total
  end
end
