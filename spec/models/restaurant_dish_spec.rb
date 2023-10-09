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
require 'rails_helper'

RSpec.describe RestaurantDish, type: :model do
  let(:restaurant_dish) { create(:restaurant_dish) }

  describe 'Associations' do
    it { should belong_to(:dish) }
    it { should belong_to(:restaurant) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(restaurant_dish).to be_valid
    end

    it 'is not valid without a price' do
      restaurant_dish.price = nil
      expect(restaurant_dish).to_not be_valid
    end

    it 'is not valid with negative price' do
      restaurant_dish.price = -1
      expect(restaurant_dish.price).to_not be > -1
    end
  end

  describe 'Outputs' do
    it { puts("RestaurantDish: #{restaurant_dish.as_json}") }
  end
end
