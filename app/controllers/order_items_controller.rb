class OrderItemsController < SessionsController
  def index
    order = @current_user.orders.find_by_id(params[:order_id])
    if order
      render json: order.order_items
    else
      render status: :not_found, json: 'No order found'
    end
  end
end
