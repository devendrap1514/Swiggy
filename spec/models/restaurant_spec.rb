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
require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let(:restaurant) { create(:restaurant) }

  describe 'Associations' do
    it { should belong_to(:owner) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(restaurant).to be_valid
    end

    it 'is not valid without a address' do
      restaurant.address = nil
      expect(restaurant).to_not be_valid
    end

    it 'is not valid without a restaurant_name' do
      restaurant.restaurant_name = nil
      expect(restaurant).to_not be_valid
    end

    it 'is not valid without a status' do
      restaurant.status = nil
      expect(restaurant).to_not be_valid
    end
  end

  describe 'Outputs' do
  end
end
