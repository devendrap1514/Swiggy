# == Schema Information
#
# Table name: order_items
#
#  id                 :bigint           not null, primary key
#  price              :decimal(, )      default(0.0), not null
#  quantity           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  order_id           :bigint           not null
#  restaurant_dish_id :bigint
#
# Indexes
#
#  index_order_items_on_order_id            (order_id)
#  index_order_items_on_restaurant_dish_id  (restaurant_dish_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (restaurant_dish_id => restaurant_dishes.id)
#
class OrderItem < ApplicationRecord
  belongs_to :restaurant_dish
  belongs_to :order

  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than: 100 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than: 1000 }
end
