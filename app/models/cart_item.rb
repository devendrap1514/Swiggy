# == Schema Information
#
# Table name: cart_items
#
#  id                 :bigint           not null, primary key
#  price              :decimal(, )      default(0.0), not null
#  quantity           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  cart_id            :bigint           not null
#  restaurant_dish_id :bigint           not null
#
# Indexes
#
#  index_cart_items_on_cart_id             (cart_id)
#  index_cart_items_on_restaurant_dish_id  (restaurant_dish_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (restaurant_dish_id => restaurant_dishes.id)
#
class CartItem < ApplicationRecord
  belongs_to :restaurant_dish
  belongs_to :cart

  # validates_presence_of :quantity, :price

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1, less_than: 1000 }
  validate :initialize_price
  # validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }

  # before_save :initialize_price

  def initialize_price
    return unless errors.blank?
    cart_dish_price = quantity * restaurant_dish.price
    # update trigger
    # update -> save -> update -> save -> update ∞
    self.price = cart_dish_price
  end
end
