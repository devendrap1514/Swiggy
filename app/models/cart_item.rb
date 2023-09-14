class CartItem < ApplicationRecord
  belongs_to :restaurant_dish
  belongs_to :cart

  validates :restaurant_dish_id, uniqueness: true
  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than: 100 }

  after_create :initialize_price

  def initialize_price
    cart_dish_price = quantity * restaurant_dish.price
    update(price: cart_dish_price)
  end
end
