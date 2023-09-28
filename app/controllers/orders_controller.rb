class OrdersController < ApiController
  before_action :find_order, only: %i[show destroy]

  def index
    render json: @current_user.orders
  end

  def create
    if @current_user.cart.present?
      cart_items = @current_user.cart.cart_items
      order = order_now(cart_items)

      begin
        cart_items.destroy_all
        # can't write 'Order placed successfully' bcz serializer won't run
        render json: order
      rescue Exception => e
        render status: :internal_server_error, json: e.message
      end
    else
      render json: 'Cart is empty'
    end
  end

  def show
    render json: @order
  end

  def destroy
    @order.destroy
    render json: 'Order deleted successfully'
  rescue Exception => e
    render status: :internal_server_error,
           json: e.message
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
    puts 'Oops. Order not placed'
  end

  def find_order
    @order = @current_user.orders.find_by_id(params[:id])
    return if @order

    render status: :not_found,
           json: 'Order not found'
  end
end
