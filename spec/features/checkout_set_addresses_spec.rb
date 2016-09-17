require 'rails_helper'

feature 'Checkout addresses' do
  include ActionView::Helpers::NumberHelper

  before do
    FactoryGirl.create(:country, name: 'Ukraine')
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:order) { user.orders_in_progress.first.decorate }
  let(:street) { 'Korolenka' }
  let(:city) { 'Dnipro' }
  let(:country) { ShoppingCart::Country.last.name }
  let(:zip) { '12345' }
  let(:phone) { '+380551234567' }

  scenario 'user redirect to checkout addresses on checkout click' do
    go_to_checkout
    check_fields
    expect(page).to have_content(t(:item_total, sub_total: order.sub_total))
    expect(page).to have_content(t(:order_total, total: order.total))
  end

  scenario 'user can set billing and shipping address' do
    go_to_checkout
    fill_in_billing_address
    fill_in_shipping_address
    click_button(t(:save_and_continue))
    check_delivery_and_back
    check_address_fields
  end

  scenario 'user can set using billing address instead of shipping' do
    go_to_checkout
    fill_in_billing_address
    check(t(:use_billing_address))
    expect(page).to have_selector('div#shipping_address', visible: false)
    click_button(t(:save_and_continue))
    check_delivery_and_back
    check_address_fields
  end

  private

  def check_fields
    expect(page).to have_css('h4', text: t(:billing_address))
    expect(page).to have_css('h4', text: t(:shipping_address))
    expect(page).to have_css('h4', text: t(:order_summary))
    expect(page).to have_css('ul.step-list')
    expect(page).to have_css('li span.checkout-element.underlined', text: t(:address))
    expect(page).to have_css("form input[type='text']", count: 12)
    expect(page).to have_css('form select', count: 2)
    expect(page).to have_selector('input[name="use_billing_address[check]"]')
    expect(page).to have_selector('input[value="SAVE AND CONTINUE"]')
  end

  def fill_in_billing_address
    fill_in 'billing_address[street]', with: street
    fill_in 'billing_address[city]', with: city
    select country, from: 'billing_address[country_id]'
    fill_in 'billing_address[zip]', with: zip
    fill_in 'billing_address[phone]', with: phone
  end

  def fill_in_shipping_address
    fill_in 'shipping_address[street]', with: street
    fill_in 'shipping_address[city]', with: city
    select country, from: 'shipping_address[country_id]'
    fill_in 'shipping_address[zip]', with: zip
    fill_in 'shipping_address[phone]', with: phone
  end

  def check_address_fields
    [
        {id: 'billing_address_street', val: street},
        {id: 'billing_address_city', val: city},
        {id: 'billing_address_zip', val: zip},
        {id: 'billing_address_phone', val: phone},
        {id: 'shipping_address_street', val: street},
        {id: 'shipping_address_city', val: city},
        {id: 'shipping_address_zip', val: zip},
        {id: 'shipping_address_phone', val: phone}
    ].each do |selector|
      expect(page).to have_selector(form_input_selector(selector))
    end
    expect(page).to have_css('select[id="billing_address_country_id"]',
                             text: country)
    expect(page).to have_css('select[id="shipping_address_country_id"]',
                             text: country)
  end

  def form_input_selector(**values)
    "input##{values[:id]}[value='#{values[:val]}']"
  end

  def check_delivery_and_back
    expect(page).to have_css('a.checkout-element', text: t(:address))
    expect(page).to have_css('li span.checkout-element.underlined', text: t(:delivery))
    click_link(t(:address))
  end
end