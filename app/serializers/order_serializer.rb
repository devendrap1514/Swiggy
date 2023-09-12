class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_price
  has_many :items, key: "items"  # used to change default json key value
end
