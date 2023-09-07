class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :restaurant_dishes, dependent: :destroy
  has_many :dishes, through: :restaurant_dishes

  validates :restaurant_name, :address, presence: true
  validates :restaurant_name, uniqueness: true

  before_validation :remove_whitespace

  def remove_whitespace
    self.restaurant_name = self.restaurant_name.strip.squeeze(" ") unless self.restaurant_name.nil?
    self.address = self.address.strip.squeeze(" ") unless self.address.nil?
  end
end
