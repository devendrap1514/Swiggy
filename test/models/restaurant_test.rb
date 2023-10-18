# == Schema Information
#
# Table name: restaurants
#
#  id              :bigint           not null, primary key
#  address         :string           not null
#  restaurant_name :string           not null
#  status          :string           default("open"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  owner_id        :bigint           not null
#
# Indexes
#
#  index_restaurants_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
