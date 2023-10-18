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
