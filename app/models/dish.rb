class Dish < ApplicationRecord
  paginates_per 2
  belongs_to :category
  has_many :restaurant_dishes, dependent: :destroy
  has_many :restaurants, through: :restaurant_dishes
  has_many_attached :dish_images

  validates :dish_name, presence: true, uniqueness: { case_sensitive: false }

  before_validation :remove_whitespace

  scope :filter_by_dish_name, ->(dish_name) { where('dish_name LIKE ?', "%#{dish_name}%") }
  scope :filter_by_category_name, lambda { |category_name|
                                    joins(:category).where('category_name LIKE ?', "%#{category_name}%")
                                  }
  scope :filter_by_restaurant_name, lambda { |restaurant_name|
                                      joins(:restaurants).where('restaurant_name LIKE ?', "%#{restaurant_name}%")
                                    }

  def remove_whitespace
    self.dish_name = StripAndSqueeze.apply(dish_name)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "dish_name", "id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "dish_images_attachments", "dish_images_blobs", "restaurant_dishes", "restaurants"]
  end
end
