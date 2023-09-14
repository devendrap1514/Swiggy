class Cart < ApplicationRecord
  belongs_to :customer, foreign_key: 'user_id'
  has_many :cart_items, dependent: :destroy

  def cart_price
    cart_items.sum(:price)
  end
end
