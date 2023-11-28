class Api::V1::OrderItemsController < Api::V1::ApiController
  def index
    order = current_user.orders.find_by_id(params[:order_id])
    if order
      @order_items = order.order_items
      output = {}
      output[:message] = "success"
      output[:data] = ActiveModelSerializers::SerializableResource.new(@order_items, each_serializer: OrderItemSerializer)
      respond_to do |format|
        format.json { render status: :ok, json: output }
        format.html
      end
    else
      render status: :not_found, json: 'No order history'
    end
  end
end
