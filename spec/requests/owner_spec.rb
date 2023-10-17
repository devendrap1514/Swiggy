require 'rails_helper'
require_relative 'shared/user_shared_request'

include TokenHelper

RSpec.describe "Owners", type: :request do
  let(:owner) { create(:user, type: Owner) }
  let(:token) { user_token(owner) }
  let(:path) { "owner" }

  include_examples "user_shared_request" do
    let(:user) { owner }
  end

  describe "GET /my_restaurant" do
    it "return owner restaurant" do
      get "/api/v1/owner/my_restaurant", headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /my_dishes" do
    it "return owner dishes" do
      get "/api/v1/owner/my_dishes", headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
  end
end
