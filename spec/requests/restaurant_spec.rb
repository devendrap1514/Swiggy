require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  let(:restaurant) { build_stubbed(:restaurant) }
  let(:token) { owner_token }

  describe "GET /index" do
    it "return list of restaurants" do
      get '/restaurants', headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return list of restaurants for status" do
      get '/restaurants', params: { status: "open" }, headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return error for wrong status" do
      get '/restaurants', params: { status: "dummy" }, headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe "POST /create" do
    it "return created successfully" do
      post '/restaurants', params: restaurant.as_json , headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return unprocessable_entity message" do
      restaurant.restaurant_name = nil
      post '/restaurants', params: restaurant.as_json, headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "return error for wrong status" do
      restaurant_json = restaurant.as_json
      restaurant_json[:status] = "undefined"
      post '/restaurants', params: restaurant_json, headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:internal_server_error)
    end
  end
end
