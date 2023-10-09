# == Schema Information
#
# Table name: restaurant_dishes
#
#  id            :integer          not null, primary key
#  price         :decimal(, )      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  dish_id       :integer          not null
#  restaurant_id :integer          not null
#
# Indexes
#
#  index_restaurant_dishes_on_dish_id        (dish_id)
#  index_restaurant_dishes_on_restaurant_id  (restaurant_id)
#
# Foreign Keys
#
#  dish_id        (dish_id => dishes.id)
#  restaurant_id  (restaurant_id => restaurants.id)
#
require 'test_helper'

class RestaurantDishTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
