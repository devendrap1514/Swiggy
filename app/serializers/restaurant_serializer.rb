class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :restaurant_name, :address, :status
end
