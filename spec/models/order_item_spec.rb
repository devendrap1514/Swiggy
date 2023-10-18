# == Schema Information
#
# Table name: order_items
#
#  id                 :bigint           not null, primary key
#  price              :decimal(, )      default(0.0), not null
#  quantity           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  order_id           :bigint           not null
#  restaurant_dish_id :bigint
#
# Indexes
#
#  index_order_items_on_order_id            (order_id)
#  index_order_items_on_restaurant_dish_id  (restaurant_dish_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (restaurant_dish_id => restaurant_dishes.id)
#
require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order_item) { create(:order_item) }

  describe 'Associations' do
    it { should belong_to(:order) }
    it { should belong_to(:restaurant_dish) }
  end

  describe 'Validation' do
    it 'is valid with valid attributes' do
      expect(order_item).to be_valid
    end

    it 'is not valid without a quantity' do
      order_item.quantity = nil
      expect(order_item).to_not be_valid
    end

    it 'is not valid with negative quantity' do
      order_item.quantity = -1
      expect(order_item.quantity).to_not be > -1
    end

    it 'is not valid without a price' do
      order_item.price = nil
      expect(order_item).to_not be_valid
    end

    it 'is not valid with negative price' do
      order_item.price = -1
      expect(order_item.price).to_not be > -1
    end
  end
end
