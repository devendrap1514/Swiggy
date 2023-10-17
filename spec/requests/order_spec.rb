require 'rails_helper'

include TokenHelper

RSpec.describe "Orders", type: :request do
  let(:customer) { FactoryBot.create(:user, type: Customer) }
  let(:customer_token) { user_token(customer) }
  let(:cart) { create(:cart, user_id: customer.id) }
  let(:restaurant_dish) { FactoryBot.create(:restaurant_dish) }
  let(:cart_item) { FactoryBot.create(:cart_item, cart: cart, restaurant_dish: restaurant_dish) }
  let(:order) { FactoryBot.create(:order, user_id: customer.id)}
  let(:header) { { Authorization: "bearer #{customer_token}" } }

  describe "GET /orders" do
    it "return all order" do
      get "/orders", headers: header
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /orders" do
    it "return empty cart" do
      post '/orders', headers: header
      expect(response).to have_http_status(:not_found)
    end
    it "return successful order" do
      cart_item
      post '/orders', headers: header
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /orders/id" do
    it "return order" do
      get "/orders/#{order.id}", headers: header
      expect(response).to have_http_status(:ok)
    end
    it "return not found" do
      get "/orders/0", headers: header
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /orders/id" do
    it "return order deleted" do
      delete "/orders/#{order.id}", headers: header
      expect(response).to have_http_status(:ok)
    end
  end

end
