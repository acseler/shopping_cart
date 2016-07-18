class CreateShoppingCartOrderItems < ActiveRecord::Migration
  def change
    create_table :shopping_cart_order_items do |t|
      t.decimal :price, precision: 8, scale: 2
      t.integer :quantity
      t.references :book, index: true
      t.references :order, index: true

      t.timestamps null: false
    end
  end
end
