# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
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
class Customer < User
  has_one :cart, foreign_key: 'user_id', dependent: :destroy
  has_many :orders, foreign_key: 'user_id', dependent: :destroy
end
