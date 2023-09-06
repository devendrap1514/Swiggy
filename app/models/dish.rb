class Dish < ApplicationRecord
  belongs_to :category
  has_many :restaurant_dishes
  has_many :restaurants, through: :restaurant_dishes
end
