# This migration comes from shopping_cart (originally 20160715130327)
class CreateShoppingCartCreditCards < ActiveRecord::Migration
  def change
    create_table :shopping_cart_credit_cards do |t|
      t.string :number
      t.integer :exp_month
      t.integer :exp_year
      t.integer :code

      t.timestamps null: false
    end
  end
end
