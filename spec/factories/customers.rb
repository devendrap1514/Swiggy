# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  name                   :string           not null
#  password_digest        :string           not null
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  type                   :string           not null
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'faker'

FactoryBot.define do
  factory :customer, class: Customer do
    name { Faker.name }
    username { Faker::Internet.username(separators: ['_']) }
    email { Faker::Internet.email(name: name) }
    password { Faker::Internet.password(min_length: 6, mix_case: true, special_characters: true) }
    password_confirmation { password }
  end
end
