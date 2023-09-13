class Item < ApplicationRecord
  belongs_to :restaurant_dish
  belongs_to :item, polymorphic: true

  validates :restaurant_dish_id, uniqueness: true

  after_create :increase_cart_price
  before_destroy :decrease_cart_price

  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than: 100 }

  def increase_cart_price
    cart = self.item if self.item_type == "Cart"
    if cart
      restaurant_dish = RestaurantDish.find_by_id(self.restaurant_dish_id)
      if cart.update(cart_price: (cart.cart_price + (self.quantity * restaurant_dish.price)))
        p "Cart price update"
      else
        p "Error while price update"
      end
    end
  end

  def decrease_cart_price
    cart = self.item if self.item_type == "Cart"
    if cart
      restaurant_dish = RestaurantDish.find_by_id(self.restaurant_dish_id)
    if cart.update(cart_price: (cart.cart_price - (self.quantity * restaurant_dish.price)))
      p "Cart price update"
    else
      p "Error while price update"
    end
    end
  end
end
