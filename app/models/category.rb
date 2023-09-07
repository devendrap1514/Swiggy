class Category < ApplicationRecord
  validates :category_name, presence: true, uniqueness: { case_sensitive: false }

  before_validation :remove_whitespace

  def remove_whitespace
    self.category_name = self.category_name.strip.squeeze(" ") unless self.category_name.nil?
  end
end
