class CartItemsController < ApplicationController
  before_action :find_cart_or_create, only: :create
  before_action :find_cart, only: [:show, :update, :destroy]
  before_action :find_cart_item, only: [:show, :update, :destroy]
  authorize_resource

  def create
    @cart_item = @cart.cart_items.new(items_params)
    if @cart_item.save
      render json: @cart_item
    else
      render status: :unprocessable_entity,
             json: { errors: @cart_item.errors.full_messages }
    end
  end

  def show
    render json: @cart_item
  end

  def update
    if @cart_item.update(items_params)
      render json: @cart_item
    else
      render status: :unprocessable_entity, json: { errors: @cart_item.errors.full_messages }
    end
  end

  def destroy
    @cart_item.destroy
    @cart.destroy if @cart.cart_items.empty?
    render status: :ok,
            json: 'Item removed from cart'
  rescue Exception => e
    render status: :internal_server_error, json: e.message
  end

  def find_cart_item
    @cart_item = @cart.cart_items.find_by_id(params[:id])
    render status: :not_found,
             json: 'No such cart item is present in cart' unless @cart_item
  end

  def find_cart
    @cart = @current_user.cart
    render json: "Cart is empty" unless @cart
  end

  def find_cart_or_create
    if @current_user.cart.present?
      find_cart
    else
      @cart = @current_user.create_cart
    end
  rescue Exception => e
    render status: :internal_server_error, json: e.message
  end

  private
    def items_params
      params.permit(:restaurant_dish_id, :quantity)
    end
end
