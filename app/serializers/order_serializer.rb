# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_order_price
  has_many :order_items

  def total_order_price
    object.order_price
  end
end
