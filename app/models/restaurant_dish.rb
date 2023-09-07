class RestaurantDish < ApplicationRecord
  belongs_to :restaurant
  belongs_to :dish

  validates :restaurant_id, uniqueness: { scope: :dish_id, message: "Restaurant has already been taken with this Dish Name"}
  validates :restaurant_id, :dish_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 5000 }
end
