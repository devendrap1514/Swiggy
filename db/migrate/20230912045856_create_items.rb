class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :restaurant_dish, null: true, foreign_key: true
      t.references :item, polymorphic: true, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
