# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class CartSerializer < ActiveModel::Serializer
  attributes :id, :total_cart_price
  has_many :cart_items

  def total_cart_price
    object.cart_price
  end
end
