module FeatureHelper
  def sign_in_as_user
    login_as user, scope: :user
    visit root_path
    expect(page).to have_content(t(:sign_out))
  end

  def go_to_orders
    sign_in_as_user
    visit books_path
    click_link(book)
    click_button(t(:add_to_cart))
    click_link(t(:orders))
    click_link(t(:orders))
  end

  def go_to_checkout
    sign_in_as_user
    visit shopping_cart.edit_order_items_path
    click_link('CHECKOUT')
    expect(page).to have_css('h3', text: 'Checkout')
  end
end