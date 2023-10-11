module TokenHelper
  def owner_token
    owner = FactoryBot.create(:user, type: Owner)
    JsonWebToken.encode(user_id: owner.id)
  end

  def customer_token
    customer = FactoryBot.create(:user, type: Customer)
    JsonWebToken.encode(user_id: customer.id)
  end
end
