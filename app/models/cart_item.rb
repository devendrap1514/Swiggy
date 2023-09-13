class CartItem < ApplicationRecord
  belongs_to :restaurant_dish
  belongs_to :cart

  validates :restaurant_dish_id, uniqueness: true
  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than: 100 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than: 1000 }
end
