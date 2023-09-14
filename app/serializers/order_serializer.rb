class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_order_price
  has_many :order_items

  def total_order_price
    object.order_price
  end
end
