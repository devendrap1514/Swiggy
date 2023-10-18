require 'rails_helper'

include TokenHelper

RSpec.describe "OrderItems", type: :request do
  let(:customer) { FactoryBot.create(:user, type: Customer) }
  let(:customer_token) { user_token(customer) }
  let(:order) { FactoryBot.create(:order, customer_id: customer.id) }
  let(:restaurant_dish) { FactoryBot.create(:restaurant_dish) }
  let(:order_item) { create(:order_item, order: order, restaurant_dish: restaurant_dish) }
  let(:header) { { Authorization: "bearer #{customer_token}" } }

  describe "GET /orders/id/order_items" do
    it "return orders" do
      order_item
      get "/api/v1/orders/#{order.id}/order_items", headers: header
      expect(response).to have_http_status(:ok)
    end
    it "return no history" do
      get "/api/v1/orders/#{order.id+1}/order_items", headers: header
      expect(response).to have_http_status(:not_found)
    end
    it "return orders" do
      order_item
      restaurant_dish.destroy
      get "/api/v1/orders/#{order.id}/order_items", headers: header
      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)
      # return array
      expect(data["data"][0]["dish_name"]).to eq nil
    end
  end
end
