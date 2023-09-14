class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :restaurant_dish, null: true, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :price, null: false, default: 0

      t.timestamps
    end
  end
end
