class AddMyStepReferenceToOrder < ActiveRecord::Migration
  def change
    add_reference :shopping_cart_orders, :my_step, index: true
  end
end
