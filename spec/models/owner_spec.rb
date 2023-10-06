require 'rails_helper'

RSpec.describe Owner, type: :model do
  subject {
    described_class.new(
      name: "Vinay Sharma",
      username: "vinay",
      email: "devendrap@shriffle.com",
      password: "Vinay123",
      password_confirmation: "Vinay123",
      type: "Owner")
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
