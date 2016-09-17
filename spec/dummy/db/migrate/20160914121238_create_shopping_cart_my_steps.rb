class CreateShoppingCartMySteps < ActiveRecord::Migration
  def change
    create_table :shopping_cart_my_steps do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
