class OrderItem < ApplicationRecord
  belongs_to :restaurant_dish
  belongs_to :order

  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than: 100 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than: 1000 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_id", "price", "quantity", "restaurant_dish_id", "updated_at"]
  end
end
