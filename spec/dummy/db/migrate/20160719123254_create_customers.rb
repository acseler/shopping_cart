class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :image
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
