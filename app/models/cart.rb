class Cart < ApplicationRecord
  belongs_to :customer, foreign_key: 'user_id'
  has_many :cart_items, dependent: :destroy

  scope :cart_price, -> { self.cart_items.sum(:price) }
end
