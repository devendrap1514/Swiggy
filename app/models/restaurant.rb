class Restaurant < ApplicationRecord
  paginates_per 2
  belongs_to :user
  has_many :restaurant_dishes, dependent: :destroy
  has_many :dishes, through: :restaurant_dishes

  validates :restaurant_name, :address, presence: true
  validates :restaurant_name, uniqueness: { scope: :address }

  VALID_STATUSES = ['open', 'close']

  validates :status, inclusion: { in: VALID_STATUSES }

  before_validation :remove_whitespace

  scope :filter_by_status, -> (status) { where status: status }
  scope :filter_by_name, -> (restaurant_name) { where("restaurant_name LIKE ?", "%#{restaurant_name}%") }
  scope :filter_by_dish, -> (dish_name) { joins(:dishes).where("dish_name LIKE ?", "%#{dish_name}%") }

  def remove_whitespace
    self.restaurant_name = self.restaurant_name.strip.squeeze(" ") unless self.restaurant_name.nil?
    self.address = self.address.strip.squeeze(" ") unless self.address.nil?
  end
end
