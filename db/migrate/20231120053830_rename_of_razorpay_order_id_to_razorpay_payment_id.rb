class RenameOfRazorpayOrderIdToRazorpayPaymentId < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :razorpay_order_id, :razorpay_payment_id
  end
end
