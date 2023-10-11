require 'rails_helper'
require_relative 'shared/user_shared_request'

RSpec.describe "Customers", type: :request do

  let(:customer) { create(:user, type: Customer) }
  let(:token) { customer_token }

  include_examples "user_shared_request" do
    let(:user) { customer }
    let(:path) { "customer" }
  end

end
