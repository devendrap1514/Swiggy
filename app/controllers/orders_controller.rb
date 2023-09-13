class OrdersController < AuthenticationController
  before_action :is_customer?
  before_action :find_order, only: [:show, :destroy]

  def index
    render json: @current_user.orders
  end

  def create
    cart_items = @current_user.cart.cart_items
    unless cart_items.empty?
      order = @current_user.orders.create
      cart_items.each do |item|
        order.order_items.create(
          restaurant_dish_id: item.restaurant_dish_id,
          quantity: item.quantity,
          price: item.price
        )
      end
      cart_items.destroy_all
      render json: order
    else
      render json: 'Cart is empty'
    end
  end

  def show
    render json: @order
  end

  def destroy
    begin
      @order.destroy
      render json: 'Order deleted successfully'
    rescue Exception => e
      render status: :internal_server_error,
              json: e.message
    end
  end

  def find_order
    @order = @current_user.orders.find_by_id(params[:_order_id])
    unless @order
      render status: :not_found,
              json: 'Order not found'
    end
  end
end
