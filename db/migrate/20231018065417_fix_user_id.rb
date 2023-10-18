class FixUserId < ActiveRecord::Migration[7.0]
  def change
    rename_column :restaurants, :user_id, :owner_id
    rename_column :carts, :user_id, :customer_id
    rename_column :orders, :user_id, :customer_id
  end
end
