class CartsController < ApiController
  before_action :find_cart

  def show
    output = {}
    output[:message] = "success"
    output[:data] = CartSerializer.new @cart
    render json: output
  end

  def destroy
    @cart.destroy
    render json: {message: 'Deleted Successfully'}
  rescue Exception => e
    render status: :internal_server_error, json: e.message
  end

  def find_cart
    @cart = @current_user.cart
    output = {}
    output[:message] = "cart is empty"
      render status: :not_found, json: output unless @cart.present?
  end
end
