class CartItemsController < ApplicationController
  # not change flow of below line that affect on find_cart method
  before_action :find_cart_or_create, only: :create
  before_action :is_same_restaurant?, only: :create
  before_action :find_cart, only: %i[show update destroy]
  before_action :find_cart_item, only: %i[show update destroy]
  authorize_resource

  def is_same_restaurant?
    return if @cart.cart_items.empty?

    new_restaurant_dish = RestaurantDish.find_by_id(params[:restaurant_dish_id])
    if new_restaurant_dish
      cart_item = @cart.cart_items.first
      cart_restaurant_dish = RestaurantDish.find_by_id(cart_item.restaurant_dish_id)

      unless new_restaurant_dish.restaurant_id == cart_restaurant_dish.restaurant_id
        render json: 'You order only one restaurant at a time'
      end
    else
      render json: 'No Restaurant Dish Available'
    end
  end

  def create
    cart_item = @cart.cart_items.find_by(restaurant_dish_id: params[:restaurant_dish_id])
    return render json: update_quantity(cart_item) if cart_item

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

  def update_quantity(cart_item)
    quantity = cart_item.quantity + params[:quantity].to_i
    cart_item.update(quantity: quantity)
    return cart_item
  end

  def find_cart_item
    @cart_item = @cart.cart_items.find_by_id(params[:id])
    return if @cart_item

    render status: :not_found,
           json: 'No such cart item is present in cart'
  end

  def find_cart
    @cart = @current_user.cart
    render json: 'Cart is empty' unless @cart
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
