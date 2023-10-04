class RestaurantDish < ApplicationRecord
  paginates_per 2
  belongs_to :restaurant
  belongs_to :dish
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :nullify

  validates :restaurant_id,
            uniqueness: { scope: :dish_id, message: 'Restaurant has already been taken with this Dish Name' }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }

  scope :filter_by_restaurant_name, lambda { |restaurant_name|
                                      joins(:restaurant).where('restaurants.restaurant_name LIKE ?', "%#{restaurant_name}%")
                                    }
  scope :filter_by_dish_name, ->(dish_name) { joins(:dish).where('dishes.dish_name LiKE ?', "%#{dish_name}%") }

end
