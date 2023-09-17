class CartItem < ApplicationRecord
  belongs_to :restaurant_dish
  belongs_to :cart

  validates :restaurant_dish_id, uniqueness: true
  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than: 100 }

  before_save :initialize_price

  def initialize_price
    cart_dish_price = quantity * restaurant_dish.price
    self.price = cart_dish_price
  end
end
