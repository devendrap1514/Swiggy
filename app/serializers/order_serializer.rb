class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_price
  has_many :items
end
