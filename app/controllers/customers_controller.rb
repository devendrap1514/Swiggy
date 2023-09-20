class CustomersController < UsersController
  def create
    customer = Customer.new(user_params)
    if customer.save
      render json: customer, status: :created
    else
      return render status: :unprocessable_entity,
             json: { errors: customer.errors.full_messages }
    end
    super(customer)
  end
end
