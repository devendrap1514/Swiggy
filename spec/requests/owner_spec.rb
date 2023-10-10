require 'rails_helper'
require 'faker'
require 'json'
require './spec/support/controller_helpers'

RSpec.configure do |c|
  c.include ControllerHelpers
end

RSpec.describe "Owners", type: :request do

  let(:owner) { create(:owner) }

  describe "POST create" do
    let(:owner) {
      name = Faker.name
      username = Faker::Internet.username(separators: ['_'])
      email = Faker::Internet.email(name: Faker.name)
      password = Faker::Internet.password(min_length: 8, mix_case: true, special_characters: true)
      password_confirmation = password
      {
        name: name,
        username: username,
        email: email,
        password: password,
        password_confirmation: password
      }
    }
    it 'return a successful response' do
      post '/owner', params: owner.as_json
      expect(response).to have_http_status(:created)
      data = JSON.parse(response.body)
      expect(data['username']).to eq owner[:username]
    end
  end

  describe "GET /owner" do
    before do
      user_login(owner)
    end

    it "return user data" do
      get '/owner'
      # data = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
    end
  end
end
