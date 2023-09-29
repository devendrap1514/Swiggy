class Category < ApplicationRecord
  validates :category_name, presence: true, uniqueness: { case_sensitive: false }
  has_many :dishes

  def self.ransackable_attributes(auth_object = nil)
    ["category_name", "created_at", "id", "updated_at"]
  end
end
