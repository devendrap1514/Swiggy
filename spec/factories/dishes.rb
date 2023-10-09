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
FactoryBot.define do
  factory :dish do
    dish_name { Faker::Food.dish }
    category { FactoryBot.create(:category) }
  end
end
