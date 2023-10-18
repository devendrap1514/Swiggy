# == Schema Information
#
# Table name: dishes
#
#  id          :bigint           not null, primary key
#  dish_name   :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_dishes_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
FactoryBot.define do
  factory :dish do
    dish_name { Faker::Food.dish }
    category { FactoryBot.create(:category) }
  end
end
