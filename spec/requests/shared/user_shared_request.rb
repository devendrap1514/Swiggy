shared_examples "user_shared_request" do
  describe "POST create" do
    let(:user) {
      name = Faker.name
      username = Faker::Internet.username(separators: ["_"])
      email = Faker::Internet.email(name: name)
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
    it "return a successful response" do
      post "/#{path}", params: user.as_json
      expect(response).to have_http_status(:created)
      data = JSON.parse(response.body)
      expect(data["username"]).to eq user[:username]
    end

    it "return unprocessable_entity for user" do
      user[:username] = "--d--"
      post "/#{path}", params: user.as_json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /user" do
    it "return user data" do
      get "/#{path}", headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return record not_found" do
      byebug
      user.destroy
      get "/#{path}", headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PUT /user" do
    it "return successful message" do
      put "/#{path}", headers: { Authorization: "bearer #{token}" }
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
