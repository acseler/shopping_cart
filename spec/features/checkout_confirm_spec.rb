require 'rails_helper'

feature 'Order confirmation' do
  include ActiveSupport::Inflector

  before do
    FactoryGirl.create(:delivery)
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:order) { user.orders_in_progress.first.decorate }
  let(:default_delivery) { order.delivery }
  let(:delivery_to_select) { ShoppingCart::Delivery.first.decorate }
  let(:credit_card) { FactoryGirl.build(:credit_card) }

  scenario 'user confirms order' do
    confirm_page
    expect(page).to have_css('h4', text: t(:confirm))
    check_shipping_address
    check_billing_address
    check_delivery
    check_payment
    check_totals
    expect(page).to have_selector("input[value='#{t(:place_order)}']")
    click_button(t(:place_order))
    expect(page).to have_css('h4', text: t(:order, order: order.id))
  end

  private

  def confirm_page
    go_to_checkout
    go_to_confirm
  end

  def go_to_confirm
    click_button(t(:save_and_continue))
    click_button(t(:save_and_continue))
    expect(page).to have_css('h4', text: 'CREDIT CARD')
    fill_in_card
    click_button(t(:save_and_continue))
  end

  def fill_in_card
    within '#new_credit_card' do
      fill_in 'credit_card[number]', with:  credit_card.number
      select 'January', from: 'credit_card[exp_month]'
      select '2017', from: 'credit_card[exp_year]'
      fill_in 'credit_card[code]', with: credit_card.code
    end
  end

  def check_shipping_address
    expect(page).to have_css('h4', text: humanize(t(:shipping_address)))
    expect(page).to have_css('.confirm-inner p',
                             text: ship_addr.full_name)
    expect(page).to have_css('.confirm-inner p', text: ship_addr.street)
    expect(page).to have_css('.confirm-inner p', text: ship_addr.city)
    expect(page).to have_css('.confirm-inner p', text: ship_addr.country.name)
    expect(page).to have_css('.confirm-inner p', text: ship_addr.phone)
  end

  def check_billing_address
    expect(page).to have_css('h4', text:  humanize(t(:billing_address)))
    expect(page).to have_css('.confirm-inner p',
                             text: bill_addr.full_name)
    expect(page).to have_css('.confirm-inner p', text: bill_addr.street)
    expect(page).to have_css('.confirm-inner p', text: bill_addr.city)
    expect(page).to have_css('.confirm-inner p', text: bill_addr.country.name)
    expect(page).to have_css('.confirm-inner p', text: bill_addr.phone)
  end

  def check_delivery
    expect(page).to have_css('h4', text: humanize(t(:shipments)))
    expect(page).to have_css('.confirm-inner p', text: order.delivery.company)
    expect(page).to have_css('.confirm-inner p', text: order.delivery.option)
  end

  def check_payment
    expect(page).to have_css('h4', text: t(:payment_information))
    expect(page).to have_css('.confirm-inner p',
                             text: order.credit_card.hide_card_number)
    expect(page).to have_css('.confirm-inner p', text: order.credit_card.exp_date)
  end

  def check_totals
    expect(page).to have_css('p',
                             text: t(:sub_total_template,
                                     sub_total: order.sub_total))
    expect(page).to have_css('p',
                             text: t(:shipping_template,
                                     shipping: order.shipping))
    expect(page).to have_css('p',
                             text: t(:order_total_template,
                                     total: order.total))
  end

  def ship_addr
    order.shipping_address.decorate
  end

  def bill_addr
    order.billing_address.decorate
  end
end