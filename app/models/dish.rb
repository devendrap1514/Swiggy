class Dish < ApplicationRecord
  paginates_per 2
  belongs_to :category
  has_many :restaurant_dishes, dependent: :destroy
  has_many :restaurants, through: :restaurant_dishes
  has_many_attached :dish_images

  validates :dish_name, presence: true, uniqueness: { case_sensitive: false }

  before_validation :remove_whitespace

  def remove_whitespace
    self.dish_name = self.dish_name.strip.squeeze(" ") unless self.dish_name.nil?
  end
end
