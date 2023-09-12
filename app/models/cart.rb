class Cart < ApplicationRecord
  belongs_to :user
  has_many :items, as: :item, dependent: :destroy

  validates :cart_price, numericality: { greater_than_or_equal_to: 0 }
end
