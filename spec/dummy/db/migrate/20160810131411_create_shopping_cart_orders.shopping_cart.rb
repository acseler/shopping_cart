# This migration comes from shopping_cart (originally 20160715130142)
class CreateShoppingCartOrders < ActiveRecord::Migration
  def change
    create_table :shopping_cart_orders do |t|
      t.decimal :total_price, precision: 8, scale: 2, default: 0
      t.decimal :sub_total_price, precision: 8, scale: 2, default: 0
      t.decimal :shipping_price, precision: 8, scale: 2, default: 0
      t.datetime :completed_date
      t.string :state
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.belongs_to :customer, polymorphic: true
      t.references :delivery
      t.references :credit_card
      t.references :coupon

      t.timestamps null: false
    end
  end
end
