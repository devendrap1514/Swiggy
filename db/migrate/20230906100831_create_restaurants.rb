class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :restaurant_name, null: false
      t.string :address, null: false
      t.string :status, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
