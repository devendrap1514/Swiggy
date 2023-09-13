class OrderItem < ApplicationRecord
  belongs_to :restaurant_dish
  belongs_to :order

  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than: 100 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than: 1000 }
end
