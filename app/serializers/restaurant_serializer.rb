class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :restaurant_name, :address, :status, :user_id
end
