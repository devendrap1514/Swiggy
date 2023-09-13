class Dish < ApplicationRecord
  paginates_per 2
  belongs_to :category
  has_many :restaurant_dishes, dependent: :destroy
  has_many :restaurants, through: :restaurant_dishes
  has_many_attached :dish_images

  validates :dish_name, presence: true, uniqueness: { case_sensitive: false }

  before_validation :remove_whitespace

  scope :filter_by_dish_name, ->(dish_name) { where("dish_name LIKE ?", "%#{dish_name}%") }
  scope :filter_by_category, ->(category_name) { joins(:category).where("category_name LIKE ?", "%#{category_name}%") }
  scope :filter_by_restaurant_name, ->(restaurant_name) { joins(:restaurants).where("restaurant_name LIKE ?", "%#{restaurant_name}%") }

  def remove_whitespace
    self.dish_name = self.dish_name.strip.squeeze(" ") unless self.dish_name.nil?
  end
end
