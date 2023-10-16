# == Schema Information
#
# Table name: order_items
#
#  id                 :integer          not null, primary key
#  price              :decimal(, )      default(0.0), not null
#  quantity           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  order_id           :integer          not null
#  restaurant_dish_id :integer
#
# Indexes
#
#  index_order_items_on_order_id            (order_id)
#  index_order_items_on_restaurant_dish_id  (restaurant_dish_id)
#
# Foreign Keys
#
#  order_id            (order_id => orders.id)
#  restaurant_dish_id  (restaurant_dish_id => restaurant_dishes.id)
#
class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :dish_name, :restaurant_name, :price
  def dish_name
    object.restaurant_dish.dish.dish_name
  rescue NoMethodError
    nil
  end

  def restaurant_name
    object.restaurant_dish.restaurant.restaurant_name
  rescue NoMethodError
    nil
  end
end
