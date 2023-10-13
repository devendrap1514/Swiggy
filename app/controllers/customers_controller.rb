class CustomersController < UsersController
  def create
    customer = Customer.new(user_params)
    if customer.save
      render json: {message: "success", data: customer}, status: :created
    else
      return render status: :unprocessable_entity, json: { message: customer.errors.full_messages }
    end
    super(customer)
  end
end
