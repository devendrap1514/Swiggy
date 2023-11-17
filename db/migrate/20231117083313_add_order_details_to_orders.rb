class AddOrderDetailsToOrders < ActiveRecord::Migration[7.0]
  def change
    change_table :orders do |t|
      t.string :name, null: false
      t.string :mobile, null: false
      t.string :address, null: false
      t.string :order_status, null: false
      t.string :payment_status, null: false
      t.string :payment_method
      t.string :razorpay_order_id
    end
    add_index :orders, :razorpay_order_id, unique: true
  end
end
