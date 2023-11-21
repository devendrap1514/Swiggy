# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar_url             :string
#  country_code           :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  phone_number           :string
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
require 'rails_helper'

require_relative 'shared/user_shared_example'

RSpec.describe Owner, type: :model do
  let(:owner) { create(:user, type: "Owner") }

  include_examples 'user_shared_example' do
    let(:user) { owner }
  end

  describe 'Outputs' do
  end
end
