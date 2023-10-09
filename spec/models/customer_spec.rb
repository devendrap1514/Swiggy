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
require 'rails_helper'

require_relative 'shared/user_shared_example'

RSpec.describe Customer, type: :model do
  let(:customer) { create :customer }

  include_examples 'user_shared_example' do
    let(:user) { customer }
  end

  describe 'Outputs' do
    it { puts("Customer: #{customer.as_json}") }
  end
end
