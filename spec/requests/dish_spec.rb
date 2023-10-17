require 'rails_helper'

include TokenHelper

RSpec.describe "Dishes", type: :request do
  let(:new_dish) { build_stubbed(:dish) }
  let(:owner) { FactoryBot.create(:user, type: Owner)}
  let(:token) { user_token(owner) }
  let(:dish) { create(:dish) }


  describe "GET /dishes" do
    it "return dishes list" do
      get '/api/v1/dishes', headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
      expect(response.body.size).to be >= 0
    end
  end

  describe "POST /dishes" do
    it "return successful message for dish create" do
      new_dish_json = new_dish.as_json
      new_dish_json[:dish_images] = [fixture_file_upload(Rails.root.join('app/assets/test_image.png'), 'image/png')]
      post '/api/v1/dishes', params: new_dish_json, headers: { Authorization: "bearer #{token}" }
      data = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(data["data"]['dish_images']).to_not eq nil
    end

    it "return unprocessable_entity" do
      new_dish.dish_name = nil
      post "/api/v1/dishes", params: new_dish.as_json, headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /dishes/id" do
    it "return dish" do
      get "/api/v1/dishes/#{dish.id}", headers: { Authorization: "bearer #{token}" }
      data = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(data["data"]['dish_name']).to eq(dish.dish_name)
    end
    it "return dish not_found" do
      get "/api/v1/dishes/#{dish.id+1}", headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PUT /dishes/id" do
    it "return successful message for dish update" do
      dish.dish_name = dish.dish_name + "1"
      put "/api/v1/dishes/#{dish.id}", params: dish.as_json(only: [:dish_name]), headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end

    it "return unprocessable_entity" do
      dish.dish_name = nil
      put "/api/v1/dishes/#{dish.id}", params: dish.as_json(only: [:dish_name]), headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
