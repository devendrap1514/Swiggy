class CartsController < ApiController
  before_action :find_cart

  def show
    render json: {message: "success", data: @cart}
  end

  def destroy
    @cart.destroy
    render json: {message: 'Deleted Successfully'}
  rescue Exception => e
    render status: :internal_server_error, json: e.message
  end

  def find_cart
    @cart = @current_user.cart
    render status: :no_content, json: {message: 'Cart is empty'} unless @cart.present?
  end
end
