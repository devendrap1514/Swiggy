# == Schema Information
#
# Table name: dishes
#
#  id          :integer          not null, primary key
#  dish_name   :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#
# Indexes
#
#  index_dishes_on_category_id  (category_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#
require 'rails_helper'

RSpec.describe Dish, type: :model do
  let(:dish) { create(:dish) }

  describe 'Associations' do
    it { should belong_to(:category) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(dish).to be_valid
    end

    it 'is not valid without a dish_name' do
      dish.dish_name = nil
      expect(dish).to_not be_valid
    end
  end

  describe 'Outputs' do
  end
end
