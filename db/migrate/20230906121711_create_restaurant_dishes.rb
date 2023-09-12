class CreateRestaurantDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_dishes do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :dish, null: false, foreign_key: true
      t.decimal :price, null: false

      t.timestamps
    end
  end
end
