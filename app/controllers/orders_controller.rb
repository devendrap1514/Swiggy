class OrdersController < ApiController
  before_action :find_order, only: %i[show destroy]

  def index
    output = {}
    output[:message] = "success"
    output[:data] = ActiveModelSerializers::SerializableResource.new(@current_user.orders, each_serializer: OrderSerializer)
    render json: output
  end

  def create
    if @current_user.cart.present?
      cart_items = @current_user.cart.cart_items
      order = order_now(cart_items)

      begin
        @current_user.cart.destroy
        output = {}
        output[:message] = "success"
        output[:message] = OrderSerializer.new order
        render json: output
      rescue Exception => e
        render status: :internal_server_error, json: { message: e.message }
      end if order
    else
      render status: :not_found, json: { message: "Cart is empty" }
    end
  end

  def show
    output = {}
    output[:message] = "success"
    output[:data] = @order
    render json: output
  end

  def destroy
    @order.destroy
    render json: {message: 'Order deleted successfully'}
  rescue Exception => e
    render status: :internal_server_error, json: {message: e.message}
  end

  def order_now(cart_items)
    ActiveRecord::Base.transaction do
      order = @current_user.orders.create
      cart_items.each do |item|
        order.order_items.create(
          restaurant_dish_id: item.restaurant_dish_id,
          quantity: item.quantity,
          price: item.price
        )
      end
      order
    end
  rescue Exception => e
    render json: {message: 'Oops. Order not placed'}
  end

  def find_order
    @order = @current_user.orders.find_by_id(params[:id])
    return if @order

    render status: :not_found, json: {message: 'Order not found'}
  end
end
