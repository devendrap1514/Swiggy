class Category < ApplicationRecord
  validates :category_name, presence: true, uniqueness: { case_sensitive: false }
  has_many :dishes
end
