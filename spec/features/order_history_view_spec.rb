require 'rails_helper'

feature 'Order history view' do
  include ActionView::Helpers::NumberHelper

  before do
    FactoryGirl.create(:customer)
    FactoryGirl.create(:order, :in_queue, customer: customer)
  end

  let(:customer) { Customer.last }
  let(:user) { customer.user }
  let(:book) { Book.last.title }

  scenario 'user can view orders' do
    go_to_orders
    order_id = first('.id').text
    first(:link, t(:view)).click
    expect(page).to have_css('h4', text: t(:order, order: order_id))
    expect(page).to have_css('span.order-state', text: t(:in_queue).humanize)
    expect(page).to have_css('a', text: t(:back_to_orders))
    click_link(t(:back_to_orders))
    expect(page).to have_css('h4', text: t(:orders))
  end
end