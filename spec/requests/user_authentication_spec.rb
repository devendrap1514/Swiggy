require 'rails_helper'

RSpec.describe "UserAuthentications", type: :request do
  let(:user) { create(:user, type: "Owner") }

  describe "POST /auth" do
    it "return login successful message" do
      post '/api/v1/auth', params: {
        username: user.username,
        password: user.password
      }
      expect(response).to have_http_status(:ok) # 200
    end
    it "return unauthorized" do
      post '/api/v1/auth', params: {
        username: user.username,
        password: '0000'
      }
      expect(response).to have_http_status(:unauthorized) # 401
    end
    it "return unauthorized" do
      post '/api/v1/auth', params: {
        username: '0000',
        password: '0000'
      }
      expect(response).to have_http_status(:unauthorized) # 401
    end
  end

  describe "DELETE /logout" do
    it "return logout successful message" do
      delete '/api/v1/auth'
      expect(response).to have_http_status(:ok) # 200
    end
  end

  describe "POST /forgot_password" do
    it "return success" do
      post '/api/v1/auth/send_mail', params: { username: user.username }
      expect(response).to have_http_status(:ok) # 200
    end
    it "return not_found userame" do
      post '/api/v1/auth/send_mail', params: { username: "--d--" }
      expect(response).to have_http_status(:not_found) # 404
    end
    it "return username must exist" do
      post '/api/v1/auth/send_mail'
      expect(response).to have_http_status(:not_found) # 404
    end
  end

  describe "POST /reset_password" do
    it "return success" do
      post '/api/v1/auth/set_password', params: { token: user.reset_password_token, password: "Ugh123" }
      expect(response).to have_http_status(:ok) # 200
    end
    it "return not_found token" do
      post '/api/v1/auth/set_password', params: { token: nil, password: "Ugh123" }
      expect(response).to have_http_status(:not_found) # 404
    end
    it "return unprocessable_entity" do
      post '/api/v1/auth/set_password', params: { token: user.reset_password_token, password: "Ugh" }
      expect(response).to have_http_status(:unprocessable_entity) # 422
    end
    it "return expire token" do
      post '/api/v1/auth/set_password', params: { token: '0000', password: "Ugh123" }
      expect(response).to have_http_status(:gone) # 410
    end
  end
end
