require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  describe "GET /index" do
    it "return list of restaurants" do
      get '/restaurants'
      byebug
      expect(response).to have_http_status(:ok)
    end
  end
end
