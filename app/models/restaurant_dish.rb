# == Schema Information
#
# Table name: restaurant_dishes
#
#  id            :bigint           not null, primary key
#  price         :decimal(, )      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  dish_id       :bigint           not null
#  restaurant_id :bigint           not null
#
# Indexes
#
#  index_restaurant_dishes_on_dish_id        (dish_id)
#  index_restaurant_dishes_on_restaurant_id  (restaurant_id)
#
# Foreign Keys
#
#  fk_rails_...  (dish_id => dishes.id)
#  fk_rails_...  (restaurant_id => restaurants.id)
#
class RestaurantDish < ApplicationRecord
  paginates_per 2
  belongs_to :restaurant
  belongs_to :dish
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :nullify

  validates :restaurant_id, uniqueness: { scope: :dish_id, message: 'Restaurant has already been taken with this Dish Name' }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }

  scope :filter_by_restaurant_name, lambda { |restaurant_name| joins(:restaurant).where('restaurants.restaurant_name ILIKE ?', "%#{restaurant_name}%") }
  scope :filter_by_dish_name, ->(dish_name) { joins(:dish).where('dishes.dish_name ILIKE ?', "%#{dish_name}%") }

end
