class RenameMobileToPhoneNumberInOrder < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :mobile, :phone_number
  end
end
