class OrdersController < AuthenticationController
  before_action :is_customer?

  def index
    render json: Order.all
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
    order = Order.find_by_id(params[:_order_id])
    if order
      render json: order
    else
      render status: :not_found,
              json: 'Order not found'
    end
  end

  def destroy
    order = Order.find_by_id(params[:_order_id])
    if order
      order.destroy
      render json: 'Order deleted successfully'
    else
      render status: :not_found,
              json: 'Order not found'
    end
  end
end
