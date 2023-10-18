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
class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_order_price
  has_many :order_items

  def total_order_price
    object.order_price
  end
end
