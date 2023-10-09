require 'rails_helper'

require_relative 'shared/user_spec'

RSpec.describe Owner, type: :model do
  let(:owner) {
    described_class.new(
      name: "Devendra Patidar",
      username: "devendra",
      email: "devendrap@shriffle.com",
      password: "Dev123",
      password_confirmation: "Dev123")
  }

  include_examples "user_spec" do
    let(:user) {owner}
  end
end
