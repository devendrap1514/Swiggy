class Api::V1::CustomersController < Api::V1::UsersController
  def create
    customer = Customer.new(user_params)
    if customer.save
      output = {}
      output[:data] = UserSerializer.new customer
      output[:message] = "success"
      render status: :created, json: output
    else
      return render status: :unprocessable_entity, json: { message: customer.errors.full_messages }
    end
    super(customer)
  end
end
