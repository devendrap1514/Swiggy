class OrdersController < AuthenticationController
  before_action :is_customer?

  def index
    render json: Order.all
  end

  def create
    cart = @user.cart
    unless cart.item_statuses.empty?
      order = @user.orders.create(order_price: cart.cart_price)
      cart.update(cart_price: 0)
      ItemStatus.where(status_type: 'Cart', status_id: cart.id).update_all(status_type: 'Order', status_id: order.id)
      render json: order
    else
      render json: 'Cart is empty'
    end
  end

  def show
    order = Order.find_by_id(params[:_order_id])
    if order
      render json: order
    else
      render json: 'Order not found', status: :not_found
    end
  end

  def destroy
    order = Order.find_by_id(params[:_order_id])
    if order
      order.destroy
      render json: 'Order deleted successfully'
    else
      render json: 'Order not found', status: :not_found
    end
  end
end
