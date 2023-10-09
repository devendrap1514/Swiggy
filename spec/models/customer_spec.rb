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
