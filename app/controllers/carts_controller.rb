class CartsController < AuthenticationController
  before_action :is_customer?
  def show
    render json: @user.cart
  end

  def destroy
    if @user.cart.item_statuses.destroy_all
      render json: 'Deleted Successfully'
    else
      render json: 'Error while deleting'
    end
  end
end
