class ItemStatus < ApplicationRecord
  belongs_to :restaurant_dish
  belongs_to :status, polymorphic: true

  after_create :increase_cart_price
  before_destroy :decrease_cart_price

  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than: 100 }

  def increase_cart_price
    # this is work as a belongs_to :cart
    cart = self.status
    restaurant_dish = RestaurantDish.find_by_id(self.restaurant_dish_id)
    if cart.update(cart_price: (cart.cart_price + (self.quantity * restaurant_dish.price)))
      p "Cart price update"
    else
      p "Error while price update"
    end
  end

  def decrease_cart_price
    cart = self.status
    restaurant_dish = RestaurantDish.find_by_id(self.restaurant_dish_id)
    if cart.update(cart_price: (cart.cart_price - (self.quantity * restaurant_dish.price)))
      p "Cart price update"
    else
      p "Error while price update"
    end
  end
end
