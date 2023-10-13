class OrderItemsController < ApiController
  def index
    order = @current_user.orders.find_by_id(params[:order_id])
    if order
      render status: :ok, json: {message: "succuss", data: order.order_items}
    else
      render status: :not_found, json: 'No order found'
    end
  end
end
