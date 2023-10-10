require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /login" do
    let(:user) { FactoryBot.create(:user) }
    it "return login successful message" do
      post '/login', params: {
        username: user.username,
        password: user.password
      }
      data = JSON.parse(response.body)
      expect(data['message']).to eq "Successfully Login"
    end
  end

  describe "DELETE /logout" do
    it "return logout successful message" do
      delete '/logout'
      expect(response.body).to eq "Successfully Logout"
    end
  end
end
