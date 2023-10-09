# == Schema Information
#
# Table name: restaurants
#
#  id              :integer          not null, primary key
#  address         :string           not null
#  restaurant_name :string           not null
#  status          :string           default("open"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_restaurants_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require 'faker'

FactoryBot.define do
  factory :restaurant, class: Restaurant do
    address { Faker::Address.street_name }
    restaurant_name { Faker::Restaurant.name }
    status { 'open' }
    user_id { FactoryBot.create(:owner).id }
  end
end
