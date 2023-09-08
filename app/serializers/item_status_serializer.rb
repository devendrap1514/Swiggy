class ItemStatusSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :dish_name, :restaurant_name
  def dish_name
    object.restaurant_dish.dish.dish_name
  end

  def restaurant_name
    object.restaurant_dish.restaurant.restaurant_name
  end
end
