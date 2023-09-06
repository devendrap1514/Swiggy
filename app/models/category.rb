class Category < ApplicationRecord
  validates :category_name, presence: true, uniqueness: { case_sensitive: false }

  before_validation :remove_whitespace

  def remove_whitespace
    self.dish_name = self.dish_name.strip.squeeze(" ") unless self.name.nil?
  end
end
