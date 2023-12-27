class SetUserIdToNullInRoom < ActiveRecord::Migration[7.0]
  def change
    change_column :rooms, :user_id, :bigint, null: true
  end
end
