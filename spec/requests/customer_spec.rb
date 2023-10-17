require 'rails_helper'
require_relative 'shared/user_shared_request'

include TokenHelper

RSpec.describe "Customers", type: :request do

  let(:customer) { create(:user, type: Customer) }
  let(:token) { user_token(customer) }

  include_examples "user_shared_request" do
    let(:user) { customer } # pass parameter to shared example
    let(:path) { "customer" }  # pass parameter to shared example
  end

end
