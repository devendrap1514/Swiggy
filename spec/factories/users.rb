# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar_url             :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  type                   :string           not null
#  uid                    :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username)
#
FactoryBot.define do
  factory :user do
    name { Faker.name }
    username { Faker::Internet.username(separators: ['_']) }
    email { Faker::Internet.email(name: name) }
    type { "Customer" }
    password { Faker::Internet.password(min_length: 8, mix_case: true, special_characters: true) }
    password_confirmation { password }
    reset_password_token { SecureRandom.hex(10) }
    reset_password_sent_at { Time.now.utc }
  end
end
