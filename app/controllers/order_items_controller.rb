class OrderItemsController < ApiController
  def index
    order = @current_user.orders.find_by_id(params[:order_id])
    if order
      output = {}
      output[:message] = "success"
      output[:data] = ActiveModelSerializers::SerializableResource.new(order.order_items, each_serializer: OrderItemSerializer)
      render status: :ok, json: output
    else
      render status: :not_found, json: 'No order history'
    end
  end
end
