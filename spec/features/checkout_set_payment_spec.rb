require 'rails_helper'

feature 'Assign payment' do

  let(:user) { FactoryGirl.create(:user) }
  let(:order) { user.orders_in_progress.first.decorate }
  let(:delivery_to_select) { order.delivery.decorate }
  let(:credit_card) { FactoryGirl.build(:credit_card) }

  scenario 'user must to fill in payment information' do
    go_to_checkout
    go_to_payment
    check_page_content
    fill_in_card(true)
    save_and_back
    check_changes
  end

  scenario 'user see errors on wrong expiration date' do
    go_to_checkout
    go_to_payment
    check_page_content
    fill_in_card(false)
    check_errors
  end

  private

  def go_to_payment
    click_button(t(:save_and_continue))
    click_button(t(:save_and_continue))
  end

  def check_page_content
    expect(page).to have_css('h4', text: t(:credit_card))
    expect(page).to have_css('input#credit_card_number')
    expect(page).to have_css('select#credit_card_exp_month')
    expect(page).to have_css('select#credit_card_exp_year')
    expect(page).to have_css('input#credit_card_code')
    expect(page).to have_css('h4', text: t(:order_summary))
    expect(page).to have_css('p', text: t(:item_total,
                                          sub_total: order.sub_total))
    expect(page).to have_css('p', text: t(:shipping_template,
                                          shipping: order.shipping))
    expect(page).to have_css('p', text: t(:order_total_template,
                                          total: order.total))
  end

  def fill_in_card(valid)
    within '#new_credit_card' do
      fill_in 'credit_card[number]', with:  credit_card.number
      select 'January', from: 'credit_card[exp_month]'
      select (valid ? '2017' : '2016'), from: 'credit_card[exp_year]'
      fill_in 'credit_card[code]', with: credit_card.code
    end
  end

  def check_errors
    click_button(t(:save_and_continue))
    expect(page).to have_css('.alert.alert-danger')
  end

  def save_and_back
    click_button(t(:save_and_continue))
    expect(page).to have_css('li span.checkout-element', text: t(:confirm))
    expect(page).to have_css('a.checkout-element', text: t(:payment))
    click_link(t(:payment))
  end

  def check_changes
    expect(page).to have_selector(card_number_selector)
    expect(page).to have_selector(option_selected, text: 'January')
    expect(page).to have_selector(option_selected, text: '2017')
    expect(page).to have_selector(card_code_selector)
  end

  def card_number_selector
    "input#credit_card_number[value='#{credit_card.number}']"
  end

  def option_selected
    "option[selected='selected']"
  end

  def card_code_selector
    "input#credit_card_code[value='#{credit_card.code}']"
  end
end