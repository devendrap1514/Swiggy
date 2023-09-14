class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :restaurant_dish, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :price, null: false, default: 0

      t.timestamps
    end
  end
end
