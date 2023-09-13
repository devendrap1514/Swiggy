class RestaurantDish < ApplicationRecord
  belongs_to :restaurant
  belongs_to :dish
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :nullify

  validates :restaurant_id, uniqueness: { scope: :dish_id, message: "Restaurant has already been taken with this Dish Name"}
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 5000 }
end
