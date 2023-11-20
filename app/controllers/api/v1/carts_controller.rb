class Api::V1::CartsController < Api::V1::ApiController
  before_action :find_cart

  def show
    output = {}
    output[:message] = "success"
    output[:data] = CartSerializer.new @cart
    respond_to do |format|
      format.json { render json: output }
      format.html
    end
  end

  def destroy
    @cart.destroy
    render json: {message: 'Deleted Successfully'}
  rescue Exception => e
    render status: :internal_server_error, json: e.message
  end

  def find_cart
    @cart = @current_user.cart
    respond_to do |format|
      format.json {
        output = {}
        output[:message] = "Cart is empty"
        render status: :not_found, json: output
      }
      format.html {
        flash.now[:notice] = "Cart is empty"
      }
    end unless @cart.present?
  end
end
