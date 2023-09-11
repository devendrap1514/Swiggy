class Order < ApplicationRecord
  belongs_to :user
  has_many :item_statuses, as: :status, dependent: :destroy

  validates :order_price, numericality: { greater_than_or_equal_to: 0 }
end
