class OrderSerializer < ActiveModel::Serializer
  attributes :id
  has_many :item_statuses
end
