class RestaurantDish < ApplicationRecord
  belongs_to :restaurant
  belongs_to :dish
  has_many :item_statuses
  before_destroy :update_item_status

  validates :restaurant_id, uniqueness: { scope: :dish_id, message: "Restaurant has already been taken with this Dish Name"}
  validates :restaurant_id, :dish_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 5000 }

  def update_item_status
    item_statuses.where(status_type: "Cart").destroy_all
    item_statuses.where(status_type: "Order").update_all(restaurant_dish_id: nil)
  end
end
