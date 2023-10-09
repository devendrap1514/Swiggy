# == Schema Information
#
# Table name: cart_items
#
#  id                 :integer          not null, primary key
#  price              :decimal(, )      default(0.0), not null
#  quantity           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  cart_id            :integer          not null
#  restaurant_dish_id :integer          not null
#
# Indexes
#
#  index_cart_items_on_cart_id             (cart_id)
#  index_cart_items_on_restaurant_dish_id  (restaurant_dish_id)
#
# Foreign Keys
#
#  cart_id             (cart_id => carts.id)
#  restaurant_dish_id  (restaurant_dish_id => restaurant_dishes.id)
#
class CartItem < ApplicationRecord
  belongs_to :restaurant_dish
  belongs_to :cart

  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than: 100 }

  before_save :initialize_price

  def initialize_price
    cart_dish_price = quantity * restaurant_dish.price
    # update trigger
    # update -> save -> update -> save -> update ∞
    self.price = cart_dish_price
  end
end
