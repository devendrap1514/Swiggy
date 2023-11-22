# == Schema Information
#
# Table name: orders
#
#  id                  :bigint           not null, primary key
#  address             :string           not null
#  name                :string           not null
#  order_status        :string           not null
#  payment_method      :string
#  payment_status      :string           not null
#  phone_number        :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  customer_id         :bigint           not null
#  razorpay_payment_id :string
#
# Indexes
#
#  index_orders_on_customer_id          (customer_id)
#  index_orders_on_razorpay_payment_id  (razorpay_payment_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :customer, class_name: "User", foreign_key: 'customer_id'
  has_many :order_items, dependent: :destroy

  validates :name, :phone_number, :address, presence: true
  validates :phone_number, length: { is: 10 }
  enum :order_status, {
    order_cancel: "order_cancel",
    order_pending: "order_pending",
    order_delivered: "order_delivered"
  }

  enum :payment_status, {
    payment_failed: "payment_failed",
    payment_pending: "payment_pending",
    payment_confirmed: "payment_confirmed"
  }

  enum :payment_method, {
    online_payment: "online_payment",
    cash_payment: "cash_payment"
  }

  def order_price
    order_items.sum(:price)
  end
end
