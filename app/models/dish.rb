# == Schema Information
#
# Table name: dishes
#
#  id          :integer          not null, primary key
#  dish_name   :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#
# Indexes
#
#  index_dishes_on_category_id  (category_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#
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
end
