class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :short_desc
      t.text :full_desc
      t.string :image
      t.decimal :price, precision: 8, scale: 2
      t.integer :stock, default: 0
      t.integer :sells, default: 0

      t.timestamps null: false
    end
  end
end
