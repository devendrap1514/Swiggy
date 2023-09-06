class Dish < ApplicationRecord
  belongs_to :category
  has_many :restaurant_dishes
  has_many :restaurants, through: :restaurant_dishes

  validates :dish_name, presence: true, uniqueness: { case_sensitive: false }

  before_validation :remove_whitespace

  def remove_whitespace
    self.dish_name = self.dish_name.strip.squeeze(" ") unless self.dish_name.nil?
  end
end
