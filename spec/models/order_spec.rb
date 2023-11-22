# == Schema Information
#
# Table name: orders
#
#  id                  :bigint           not null, primary key
#  address             :string           not null
#  name                :string           not null
#  order_status        :string           not null
#  payment_method      :string
#  payment_status      :string           not null
#  phone_number        :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  customer_id         :bigint           not null
#  razorpay_payment_id :string
#
# Indexes
#
#  index_orders_on_customer_id          (customer_id)
#  index_orders_on_razorpay_payment_id  (razorpay_payment_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => users.id)
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }

  describe 'Associations' do
    it { should belong_to(:customer) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(order).to be_valid
    end
  end

  describe 'Outputs' do
    it "price return positive integer" do
      expect(order.order_price).to be >= 0
    end
  end
end
