# == Schema Information
#
# Table name: carts
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :bigint           not null
#
# Indexes
#
#  index_carts_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => users.id)
#
require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { create(:cart) }

  describe 'Associations' do
    it { should belong_to(:customer) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(cart).to be_valid
    end
  end

  describe 'Outputs' do
    it "price return positive integer" do
      expect(cart.cart_price).to be >= 0
    end
  end
end
