# == Schema Information
#
# Table name: restaurants
#
#  id              :bigint           not null, primary key
#  address         :string           not null
#  restaurant_name :string           not null
#  status          :string           default("open"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  owner_id        :bigint           not null
#
# Indexes
#
#  index_restaurants_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class Restaurant < ApplicationRecord
  paginates_per 2
  belongs_to :owner, class_name: "User", foreign_key: 'owner_id'
  has_many :restaurant_dishes, dependent: :destroy
  has_many :dishes, through: :restaurant_dishes

  validates :restaurant_name, :address, presence: true
  validates :restaurant_name, uniqueness: { scope: :address }
  enum :status, {
    open: 'open',
    close: 'close'
  }

  validates :status, presence: true, inclusion: { in: ['open', 'close']}

  before_validation :remove_whitespace

  scope :filter_by_restaurant_name, ->(restaurant_name) { where('restaurant_name ILIKE ?', "%#{restaurant_name}%") }
  scope :filter_by_dish_name, ->(dish_name) { joins(:dishes).where('dish_name ILIKE ?', "%#{dish_name}%") }

  def remove_whitespace
    self.restaurant_name = restaurant_name.strip.squeeze(' ') unless restaurant_name.nil?
    self.address = address.strip.squeeze(' ') unless address.nil?
  end
end
