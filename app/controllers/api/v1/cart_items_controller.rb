class Api::V1::CartItemsController < Api::V1::ApiController
  before_action :find_cart_or_create, only: :create
  before_action :is_same_restaurant?, only: :create
  before_action :find_cart, only: %i[show update destroy]
  before_action :find_cart_item, only: %i[show update destroy]

  def is_same_restaurant?
    return unless @cart.present?
    return if @cart.cart_items.empty?

    new_restaurant_dish = RestaurantDish.find_by_id(params[:restaurant_dish_id])
    if new_restaurant_dish
      cart_item = @cart.cart_items.first
      cart_restaurant_dish = RestaurantDish.find_by_id(cart_item.restaurant_dish_id)

      unless new_restaurant_dish.restaurant_id == cart_restaurant_dish.restaurant_id
        render json: { message: 'You order only one restaurant at a time' }
      end
    else
      render json: { message: 'No Restaurant Dish Available' }
    end
  end

  def create
    cart_item = @cart.cart_items.find_by(restaurant_dish_id: params[:restaurant_dish_id])
    # return render json: cart_item.update_quantity(params[:quantity].to_i) if cart_item

    if cart_item
      output = {}
      output[:message]
      output[:data] = cart_item if cart_item.update_quantity(params[:quantity].to_i)
      respond_to do |format|
        format.json {
          if output
            render json: output
          else
            render json: ""
          end
        }
        format.html {  }
      end
      return
    end

    cart_item = @cart.cart_items.new(items_params)
    byebug
    if cart_item.save
      respond_to do |format|
        format.json  { render json: cart_item }
        format.html
      end
    else
      @cart.cart_items.delete(cart_item)
      destroy_cart_if_empty
      render status: :unprocessable_entity, json: { message: cart_item.errors.full_messages }
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
    destroy_cart_if_empty
    render status: :ok,
           json: 'Item removed from cart'
  rescue Exception => e
    render status: :internal_server_error, json: e.message
  end

  def find_cart_item
    @cart_item = @cart.cart_items.find_by_id(params[:id])
    return if @cart_item

    render status: :not_found,
           json: 'No such cart item is present in cart'
  end

  def find_cart
    @cart = @current_user.cart
    return render status: :not_found, json: 'Cart is empty' unless @cart
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

  def destroy_cart_if_empty
    @cart.destroy if @cart.cart_items.empty?
  end

  private

  def items_params
    params.permit(:restaurant_dish_id, :quantity)
  end
end
