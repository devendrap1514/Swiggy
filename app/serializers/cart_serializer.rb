class CartSerializer < ActiveModel::Serializer
  attributes :id, :total_cart_price
  has_many :cart_items
  def total_cart_price
    object.cart_items.sum(:price)
  end
end
