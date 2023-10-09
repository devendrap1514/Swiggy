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

require_relative 'shared/user_spec'

RSpec.describe Customer, type: :model do
  # subject {
  #   described_class.new(
  #     name: "Devendra Patidar",
  #     username: "devendra",
  #     email: "devendrap@shriffle.com",
  #     password: "Dev123",
  #     password_confirmation: "Dev123",
  #     type: "Customer")
  # }

  let(:customer) {
    described_class.new(
      name: "Devendra Patidar",
      username: "devendra",
      email: "devendrap@shriffle.com",
      password: "Dev123",
      password_confirmation: "Dev123")
  }

  include_examples "user_spec" do
    let(:user) {customer}
  end

end
