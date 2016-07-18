class CreateShoppingCartCoupons < ActiveRecord::Migration
  def change
    create_table :shopping_cart_coupons do |t|
      t.integer :per_cent
      t.string :code

      t.timestamps null: false
    end
  end
end
