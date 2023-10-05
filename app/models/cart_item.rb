class CartItem < ApplicationRecord
  belongs_to :restaurant_dish
  belongs_to :cart

  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than: 100 }

  before_save :initialize_price

  def initialize_price
    cart_dish_price = quantity * restaurant_dish.price
    # update trigger
    # update -> save -> update -> save -> update ∞
    self.price = cart_dish_price
  end
end
