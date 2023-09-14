class Order < ApplicationRecord
  belongs_to :customer, foreign_key: 'user_id'
  has_many :order_items, dependent: :destroy

  def order_price
    order_items.sum(:price)
  end
end
