require 'rails_helper'

include TokenHelper

RSpec.describe "CartItems", type: :request do
  let(:customer) { FactoryBot.create(:user, type: Customer) }
  let(:customer_token) { user_token(customer) }
  let(:cart) { create(:cart, user_id: customer.id) }
  let(:restaurant_dish) { FactoryBot.create(:restaurant_dish) }
  let(:different_restaurant_dish) { FactoryBot.create(:restaurant_dish) }
  let(:cart_item) { FactoryBot.create(:cart_item, cart: cart, restaurant_dish: restaurant_dish) }
  let(:header) { { Authorization: "bearer #{customer_token}" } }

  describe "POST cart/cart_items" do
    it "return successful created cart_item" do
      cart_item_json = { restaurant_dish_id: restaurant_dish.id, quantity: 4 }
      post '/cart/cart_items', params: cart_item_json, headers: header
      data = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
    end
    it "return unprocessable_entity" do
      cart_item_json = { restaurant_dish_id: restaurant_dish.id+1, quantity: 4 }
      post '/cart/cart_items', params: cart_item_json, headers: header
      data = JSON.parse(response.body)
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "return successful update cart_item" do
      cart_item
      cart_item_json = { restaurant_dish_id: restaurant_dish.id, quantity: 4 }
      post '/cart/cart_items', params: cart_item_json, headers: header
      data = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
    end
    it "return successful but order with same restaurant" do
      cart_item
      cart_item_json = { restaurant_dish_id: different_restaurant_dish.id, quantity: 4 }
      post '/cart/cart_items', params: cart_item_json, headers: header
      expect(response).to have_http_status(:ok)
    end
    it "return not found restaurant_dish" do
      cart_item
      cart_item_json = { restaurant_dish_id: 0, quantity: 4 }
      post '/cart/cart_items', params: cart_item_json, headers: header
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET cart/cart_items/id" do
    it "return cart is empty" do
      get "/cart/cart_items/1", headers: header
      expect(response).to have_http_status(:not_found)
    end
    it "return cart_item" do
      get "/cart/cart_items/#{cart_item.id}", headers: header
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT cart/cart_item/id" do
    it "return successful update cart_item" do
      cart_item_json = { restaurant_dish_id: restaurant_dish.id, quantity: 4 }
      put "/cart/cart_items/#{cart_item.id}", params: cart_item_json, headers: header
      expect(response).to have_http_status(:ok)
    end
    it "return unprocessable_entity cart_item" do
      cart_item_json = { restaurant_dish_id: restaurant_dish.id+1, quantity: 4 }
      put "/cart/cart_items/#{cart_item.id}", params: cart_item_json, headers: header
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "return not found cart_item" do
      cart_item_json = { restaurant_dish_id: restaurant_dish.id, quantity: 4 }
      put "/cart/cart_items/#{cart_item.id+1}", params: cart_item_json, headers: header
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE cart/cart_items/id" do
    it "return successful remove cart_item" do
      delete "/cart/cart_items/#{cart_item.id}", headers: header
      expect(response).to have_http_status(:ok)
    end
  end

end
