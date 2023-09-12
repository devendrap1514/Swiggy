class RestaurantDish < ApplicationRecord
  belongs_to :restaurant
  belongs_to :dish
  has_many :items
  before_destroy :update_items

  validates :restaurant_id, uniqueness: { scope: :dish_id, message: "Restaurant has already been taken with this Dish Name"}
  validates :restaurant_id, :dish_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 5000 }

  def update_items
    items.where(item_type: "Cart").destroy_all
    items.where(item_type: "Order").update_all(restaurant_dish_id: nil)
  end
end
