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
FactoryBot.define do
  factory :restaurant_dish do
    dish { FactoryBot.create(:dish) }
    restaurant { FactoryBot.create(:restaurant) }
    price { 100 }
  end
end
