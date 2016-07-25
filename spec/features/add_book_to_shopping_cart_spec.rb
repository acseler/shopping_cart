require 'rails_helper'

feature 'Shopping cart' do
  include ActiveSupport::NumberHelper

  let(:customer) { FactoryGirl.create(:customer) }
  let(:user) { customer.user }
  let(:order) { customer.order_in_proggress }
  let(:order_item) { order.order_items.last }
  let(:book) { order_item.book }
  let(:item_id) { order_item.id }
  let(:coupon) { FactoryGirl.create(:coupon) }

  scenario 'user can add book to shopping cart' do
    go_to_cart
    check_content
  end

  scenario 'user can edit order' do
    go_to_cart
    fill_in "quantity[#{item_id}]", with: '11'
    click_button('UPDATE')
    expect(page).to have_selector("input[name='quantity[#{item_id}]']")
    expect(page).to have_selector("input[value='11']")
    expect(page).to have_css('span.total',
                             text: number_to_currency(11 * order_item.price))
  end

  scenario 'user can remove items from order' do
    go_to_cart
    expect(page).to have_css('a.btn', text: 'x')
    find("//a[href='/cart/order_items/#{item_id}']").click
    expect(page).to have_content('Cart: (EMPTY)')
    expect(page).to have_content('You have 0 items in order')
    expect(page).to have_css('div div img.img-rounded.center-block', count: 0)
  end

  scenario 'user can use coupon code' do
    go_to_cart
    fill_in 'coupon', with: coupon.code
    click_button(t(:update))
    expect(page).to have_css('span', text: t(:discount))
    expect(page).to have_css('p', text: "#{coupon.per_cent}%")
    expect(page).not_to have_selector("input[name='coupon']")
  end

  private

  def go_to_cart
    sign_in
    add_book
    visit shopping_cart.edit_order_items_path
  end

  def sign_in
    login_as user, scope: :user
    visit root_path
    expect(page).to have_content(t(:sign_out))
  end

  def add_book
    click_link(t(:shop))
    click_link("#{book.title}")
    click_button(t(:add_to_cart))
    expect(page).to have_content('Cart: (1)')
  end

  def check_content
    expect(page).to have_content('You have 1 item in order')
    expect(page).to have_css('a', text: t(:empty_cart))
    expect(page).to have_css('a', text: t(:continue_shopping))
    expect(page).to have_css('a', text: t(:checkout))
    expect(page).to have_selector('input[value="UPDATE"]')
    expect(page).to have_selector('input[name="coupon"]')
  end
end