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
FactoryBot.define do
  factory :cart_item do
    price { 100 }
    quantity { 5 }
    cart { FactoryBot.create(:cart) }
    restaurant_dish { FactoryBot.create(:restaurant_dish) }
  end
end
