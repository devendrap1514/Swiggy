class OrdersController < AuthenticationController
  before_action :is_customer?
  before_action :find_order, only: [:show, :destroy]

  def index
    render json: @current_user.orders
  end

  def create
    cart = @current_user.cart
    unless cart.items.empty?
      order = @current_user.orders.create(order_price: cart.cart_price)
      cart.update(cart_price: 0)
      Item.where(item_type: 'Cart', item_id: cart.id).update_all(item_type: 'Order', item_id: order.id)
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
