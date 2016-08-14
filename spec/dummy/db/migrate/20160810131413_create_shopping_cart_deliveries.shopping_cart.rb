# This migration comes from shopping_cart (originally 20160715130258)
class CreateShoppingCartDeliveries < ActiveRecord::Migration
  def change
    create_table :shopping_cart_deliveries do |t|
      t.string :company
      t.string :option
      t.decimal :price, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
