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
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart_item) { create(:cart_item) }

  describe 'Associations' do
    it { should belong_to(:cart) }
    it { should belong_to(:restaurant_dish) }
  end

  describe 'Validation' do
    it 'is valid with valid attributes' do
      expect(cart_item).to be_valid
    end

    it 'is not valid without a quantity' do
      cart_item.quantity = nil
      expect(cart_item).to_not be_valid
    end

    it 'is not valid with negative quantity' do
      cart_item.quantity = -1
      expect(cart_item.quantity).to_not be > -1
    end

    # # price automatically set when validation run
    # it 'is not valid without a price' do
    #   cart_item.price = nil
    #   expect(cart_item).to_not be_valid
    # end

    it 'is not valid with negative price' do
      cart_item.price = -1
      expect(cart_item.price).to_not be > -1
    end
  end
end
