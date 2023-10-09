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
class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :restaurant_name, :address, :status, :user_id
end
