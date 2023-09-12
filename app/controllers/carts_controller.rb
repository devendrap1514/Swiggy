class CartsController < AuthenticationController
  before_action :is_customer?
  def show
    render status: :ok,
           json: @current_user.cart
  end

  def destroy
    if @current_user.cart.items.destroy_all
      render status: :ok,
             json: 'Deleted Successfully'
    else
      render status: :internal_server_error,
             json: 'Error while deleting'
    end
  end
end
