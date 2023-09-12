class CartSerializer < ActiveModel::Serializer
  attributes :id, :cart_price
  has_many :items
end
