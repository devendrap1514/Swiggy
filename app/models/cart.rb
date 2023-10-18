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
class Cart < ApplicationRecord
  belongs_to :customer, class_name: "User", foreign_key: 'customer_id'
  has_many :cart_items, dependent: :destroy

  def cart_price
    cart_items.sum(:price)
  end
end
