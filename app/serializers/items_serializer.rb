class ItemsSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :dish_name, :restaurant_name
  def dish_name
    object.restaurant_dish.dish.dish_name
  rescue NoMethodError
    "Dish is not available"
  end

  def restaurant_name
    object.restaurant_dish.restaurant.restaurant_name
  rescue NoMethodError
      "Restaurant is not available"
  end
end
