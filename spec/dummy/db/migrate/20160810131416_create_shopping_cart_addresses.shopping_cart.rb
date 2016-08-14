# This migration comes from shopping_cart (originally 20160810082625)
class CreateShoppingCartAddresses < ActiveRecord::Migration
  def change
    create_table :shopping_cart_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :city
      t.string :zip
      t.string :phone
      t.references :country

      t.timestamps null: false
    end
  end
end
