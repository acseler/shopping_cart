require 'rails_helper'

feature 'Assign delivery' do
  include ActionView::Helpers::NumberHelper

  let(:customer) { FactoryGirl.create(:customer) }
  let(:user) { customer.user }
  let(:order) { customer.order_in_proggress.decorate }
  let(:default_delivery) { order.delivery }
  let(:delivery_to_select) { ShoppingCart::Delivery.first.decorate }

  before do
    FactoryGirl.create(:delivery)
  end

  scenario 'user chooses delivery for order' do
    go_to_checkout
    click_button(t(:save_and_continue))
    check_delivery_content
    check_delivery_assignation
  end

  scenario 'order summary changes on delivery changing' do
    go_to_checkout
    click_button(t(:save_and_continue))
    expect(page).to have_css('p.sub-total', text: price_in_view(order.sub_total_price))
    expect(page).to have_css('p span.shipping', text: price_in_view(default_delivery.price))
    expect(page).to have_css('p span.total', text: total_price(default_delivery))
    choose(delivery_to_select.delivery_title)
    expect(page).to have_css('p span.shipping', text: price_in_view(delivery_to_select.price))
    expect(page).to have_css('p span.total', text: total_price(delivery_to_select))
  end

  private

  def check_delivery_content
    expect(page).to have_css('h3', text: 'Checkout')
    expect(page).to have_css('label input.radio_button', count: 2)
    expect(page).to have_selector("input[checked='checked']", count: 1)
    expect(page).to have_css(label_selector(default_delivery),
                             text: default_delivery.delivery_title)
  end

  def check_delivery_assignation
    choose(delivery_to_select.delivery_title)
    click_button(t(:save_and_continue))
    expect(page).to have_css('a.checkout-element', text: t(:address))
    expect(page).to have_css('a.checkout-element', text: t(:delivery))
    expect(page).to have_css('span.checkout-element.underlined', text: t(:payment))
    click_link(t(:delivery))
    expect(page).to have_selector("#{label_selector(delivery_to_select)} input[checked='checked']")
  end

  def label_selector(delivery)
    "label.control-label[for='delivery_delivery_id_#{delivery.id}']"
  end

  def price_in_view(price)
    number_to_currency(price)
  end

  def total_price(delivery)
    price_in_view(delivery.price + order.sub_total_price)
  end
end