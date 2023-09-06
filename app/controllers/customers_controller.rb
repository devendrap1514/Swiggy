class CustomersController < UsersController
  def create
    @Customer = Customer.new(user_params)
    if @Customer.save
      render json: @Customer, status: :created
    else
      render json: { errors: @Customer.errors.full_messages },
             status: :unprocessable_entity
    end
  end
end
