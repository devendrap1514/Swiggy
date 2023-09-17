class OrdersController < ApplicationController
  before_action :find_order, only: %i[show destroy]
  authorize_resource

  def index
    render json: @current_user.orders
  end

  def create
    unless @current_user.cart.present?
      render json: 'Cart is empty'
    else
      cart_items = @current_user.cart.cart_items
      order_now(cart_items)

      begin
        cart_items.destroy_all
        render json: "Order successfully completed"
      rescue Exception => e
        render status: :internal_server_error, json: e.message
      end
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
    end
  rescue Exception => e
    puts "Oops. Order not placed"
  end

  def find_order
    @order = @current_user.orders.find_by_id(params[:id])
    return if @order

    render status: :not_found,
           json: 'Order not found'
  end
end
