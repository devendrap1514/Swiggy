class CartSerializer < ActiveModel::Serializer
  attributes :id, :cart_price
  has_many :item_statuses, key: "items"  # used to change json key value
end
