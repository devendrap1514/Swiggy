# == Schema Information
#
# Table name: restaurant_dishes
#
#  id            :bigint           not null, primary key
#  price         :decimal(, )      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  dish_id       :bigint           not null
#  restaurant_id :bigint           not null
#
# Indexes
#
#  index_restaurant_dishes_on_dish_id        (dish_id)
#  index_restaurant_dishes_on_restaurant_id  (restaurant_id)
#
# Foreign Keys
#
#  fk_rails_...  (dish_id => dishes.id)
#  fk_rails_...  (restaurant_id => restaurants.id)
#
class RestaurantDishSerializer < ActiveModel::Serializer
  attributes :id, :price
  belongs_to :dish
  belongs_to :restaurant
end
