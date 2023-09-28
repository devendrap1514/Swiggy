class CartsController < ApiController
  before_action :find_cart

  def show
    render json: @cart
  end

  def destroy
    @cart.destroy
    render json: 'Deleted Successfully'
  rescue Exception => e
    render status: :internal_server_error,
           json: e.message
  end

  def find_cart
    @cart = @current_user.cart
    render json: 'Cart is empty' unless @cart.present?
  end
end
