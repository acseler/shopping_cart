class CreateMagazines < ActiveRecord::Migration
  def change
    create_table :magazines do |t|
      t.string :title
      t.decimal :price, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
