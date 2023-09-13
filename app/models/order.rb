class Order < ApplicationRecord
  belongs_to :customer, foreign_key: 'user_id'
  has_many :order_items, dependent: :destroy

  scope :order_price, -> { self.order_price.sum(:price) }
end
