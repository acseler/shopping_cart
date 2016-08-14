# This migration comes from shopping_cart (originally 20160810130728)
class CreateShoppingCartCountries < ActiveRecord::Migration
  def change
    create_table :shopping_cart_countries do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
