shared_examples "user_shared_request" do
  describe "POST create" do
    let(:new_user) { FactoryBot.build_stubbed(:user) }
    let(:new_user_json) { new_user.as_json(only: [:name, :username, :email]).merge({password: new_user.password, password_confirmation: new_user.password}) }

    it "return a successful response" do
      new_user_json[:profile_picture] = fixture_file_upload(Rails.root.join('app/assets/test_image.png'), 'image/png')
      post "/#{path}", params: new_user_json
      expect(response).to have_http_status(:created)
      data = JSON.parse(response.body)
      expect(data["username"]).to eq new_user[:username]
    end

    it "return unprocessable_entity for user" do
      new_user_json[:username] = "--d--"
      post "/#{path}", params: new_user_json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /user" do
    it "return user data" do
      get "/#{path}", headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return unauthorized" do
      get "/#{path}", headers: { Authorization: "bearer #{0000}" }
      expect(response).to have_http_status(:unauthorized)
    end
    it "return record not found" do
      token = JsonWebToken.encode(user_id: 0)
      get "/#{path}", headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PUT /user" do
    it "return successful message" do
      put "/#{path}", params: user.as_json, headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return unprocessable_entity user" do
      user.username = "--0--"
      put "/#{path}", params: user.as_json, headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /user" do
    it "return successful message" do
      delete "/#{path}", headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
  end
end
