# == Schema Information
#
# Table name: carts
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :bigint           not null
#
# Indexes
#
#  index_carts_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => users.id)
#
class CartSerializer < ActiveModel::Serializer
  attributes :id, :total_cart_price
  has_many :cart_items

  def total_cart_price
    object.cart_price
  end
end
