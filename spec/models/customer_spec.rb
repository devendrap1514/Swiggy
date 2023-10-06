require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject {
    described_class.new(
      name: "Devendra Patidar",
      username: "devendra",
      email: "devendrap@shriffle.com",
      password: "Dev123",
      password_confirmation: "Dev123",
      type: "Customer")
  }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a username" do
    subject.username = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a email"
  it "is not valid without a password"
  it "is not valid without a confirmation_password"
end
