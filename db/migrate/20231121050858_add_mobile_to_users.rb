class AddMobileToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :country_code, :string
    add_column :users, :phone_number, :string
  end
end
