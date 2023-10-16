# == Schema Information
#
# Table name: cart_items
#
#  id                 :integer          not null, primary key
#  price              :decimal(, )      default(0.0), not null
#  quantity           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  cart_id            :integer          not null
#  restaurant_dish_id :integer          not null
#
# Indexes
#
#  index_cart_items_on_cart_id             (cart_id)
#  index_cart_items_on_restaurant_dish_id  (restaurant_dish_id)
#
# Foreign Keys
#
#  cart_id             (cart_id => carts.id)
#  restaurant_dish_id  (restaurant_dish_id => restaurant_dishes.id)
#
class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :dish_name, :restaurant_name, :price
  def dish_name
    object.restaurant_dish.dish.dish_name
  end

  def restaurant_name
    object.restaurant_dish.restaurant.restaurant_name
  end
end
