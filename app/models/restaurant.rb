class Restaurant < ApplicationRecord
  paginates_per 2
  belongs_to :owner, foreign_key: 'user_id'
  has_many :restaurant_dishes, dependent: :destroy
  has_many :dishes, through: :restaurant_dishes

  validates :restaurant_name, :address, presence: true
  validates :restaurant_name, uniqueness: { scope: :address }

  enum :status, {
    open: 'open',
    close: 'close'
  }

  before_validation :remove_whitespace

  scope :filter_by_restaurant_name, ->(restaurant_name) { where('restaurant_name LIKE ?', "%#{restaurant_name}%") }
  scope :filter_by_dish_name, ->(dish_name) { joins(:dishes).where('dish_name LIKE ?', "%#{dish_name}%") }

  def remove_whitespace
    self.restaurant_name = restaurant_name.strip.squeeze(' ') unless restaurant_name.nil?
    self.address = address.strip.squeeze(' ') unless address.nil?
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "id", "restaurant_name", "status", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["dishes", "owner", "restaurant_dishes"]
  end
end
