class CartsController < ApplicationController
  authorize_resource
  def show
    render json: @current_user.cart
  end

  def destroy
    @current_user.cart.cart_items.destroy_all
    render json: 'Deleted Successfully'
  rescue Exception => e
    render status: :internal_server_error,
           json: e.message
  end
end
