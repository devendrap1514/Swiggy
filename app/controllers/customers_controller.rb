class CustomersController < UsersController
  def create
    create_user("Customer")
  end
end
