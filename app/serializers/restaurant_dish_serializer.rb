class RestaurantDishSerializer < ActiveModel::Serializer
  attributes :id, :price
  belongs_to :dish
  belongs_to :restaurant
end
