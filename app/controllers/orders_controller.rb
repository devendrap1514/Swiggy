class OrdersController < ApplicationController
  before_action :find_order, only: %i[show destroy]
  authorize_resource

  def index
    render json: @current_user.orders
  end

  def create
    cart_items = @current_user.cart.cart_items

    if cart_items.empty?
      render json: 'Cart is empty'
    else
      # Create Empty Order
      order = @current_user.orders.create

      order_now(order, cart_items)

      begin
        cart_items.destroy_all
      rescue Exception => e
        render status: :internal_server_error, json: e.message
      end
      render json: order
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

  def order_now(order, cart_items)
    # Add Cart Item in Order Item
    cart_items.each do |item|
      order.order_items.create(
        restaurant_dish_id: item.restaurant_dish_id,
        quantity: item.quantity,
        price: item.price
      )
    end
  end

  def find_order
    @order = @current_user.orders.find_by_id(params[:id])
    return if @order

    render status: :not_found,
           json: 'Order not found'
  end
end
