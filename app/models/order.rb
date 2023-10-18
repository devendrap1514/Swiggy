# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :bigint           not null
#
# Indexes
#
#  index_orders_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :customer, class_name: "User", foreign_key: 'customer_id'
  has_many :order_items, dependent: :destroy

  def order_price
    order_items.sum(:price)
  end
end
