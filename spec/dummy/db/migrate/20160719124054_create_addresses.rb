class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :city
      t.string :zip
      t.string :phone
      t.references :country, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
