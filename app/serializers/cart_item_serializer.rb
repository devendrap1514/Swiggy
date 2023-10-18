# == Schema Information
#
# Table name: cart_items
#
#  id                 :bigint           not null, primary key
#  price              :decimal(, )      default(0.0), not null
#  quantity           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  cart_id            :bigint           not null
#  restaurant_dish_id :bigint           not null
#
# Indexes
#
#  index_cart_items_on_cart_id             (cart_id)
#  index_cart_items_on_restaurant_dish_id  (restaurant_dish_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (restaurant_dish_id => restaurant_dishes.id)
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
