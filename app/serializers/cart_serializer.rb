class CartSerializer < ActiveModel::Serializer
  attributes :id, :cart_price
  has_many :items, key: "items"  # used to change default json key value
end
