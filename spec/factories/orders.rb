# == Schema Information
#
# Table name: orders
#
#  id                  :bigint           not null, primary key
#  address             :string           not null
#  mobile              :string           not null
#  name                :string           not null
#  order_status        :string           not null
#  payment_method      :string
#  payment_status      :string           not null
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
FactoryBot.define do
  factory :order do
    customer_id { FactoryBot.create(:user, type: "Customer").id }
  end
end
