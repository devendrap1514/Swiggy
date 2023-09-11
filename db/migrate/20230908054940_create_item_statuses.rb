class CreateItemStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :item_statuses do |t|
      t.references :restaurant_dish, null: true, foreign_key: true
      t.references :status, polymorphic: true, null: false
      t.integer :quantity

      t.timestamps
    end
  end
end
