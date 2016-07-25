require 'rails_helper'

feature 'Order history' do

  before(:each) do
    FactoryGirl.create(:customer)
    FactoryGirl.create(:book)
    FactoryGirl.create(:order, :in_queue, customer: customer)
    FactoryGirl.create(:order, :in_delivery, customer: customer)
    FactoryGirl.create(:order, :delivered, customer: customer)
  end

  let(:customer) { Customer.last }
  let(:user) { customer.user }
  let(:order) { customer.order_in_proggress.decorate }
  let(:book) { Book.last.title }

  scenario 'user can checks status of recent orders' do
    go_to_orders
    check_order_in_progress
    check_headers
    check_orders_title(:in_queue)
    check_orders_title(:in_delivery)
    check_orders_title(:delivered)
    check_orders_fields
  end

  scenario 'user see message if no orders' do
    customer.orders = []
    customer.orders << ShoppingCart::Order.new
    sign_in_as_user
    visit shopping_cart.orders_path
    expect(page).to have_css('h4', text: t(:you_have_no_orders))
  end

  private

  def check_order_in_progress
    expect(page).to have_css('h4', text: t(:orders))
    expect(page).to have_css('div.underlined', text: t(:in_progress))
    expect(page).to have_css('a.btn.btn-default', text: t(:go_to_cart))
    expect(page).to have_css('.pull-right',
                             text: t(:sub_total_template,
                                     sub_total: order.sub_total))
  end

  def check_orders_title(type)
    expect(page).to have_css('.underlined', text: t(type))
  end

  def check_headers
    expect(page).to have_css('.text-center', text: t(:number), count: 3)
    expect(page).to have_css('.text-center', text: t(:completed_date), count: 3)
    expect(page).to have_css('.col-xs-2.text-center', text: t(:total), count: 3)
  end

  def check_orders_fields
    expect(page).to have_css('.text-center.id', count: 3)
    expect(page).to have_css('.text-center.date', count: 3)
    expect(page).to have_css('.text-center.price', count: 3)
  end
end