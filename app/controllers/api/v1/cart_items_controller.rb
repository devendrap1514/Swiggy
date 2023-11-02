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
        respond_to do |format|
          format.json { render json: { message: 'You order only one restaurant at a time' } }
          format.html { redirect_to request.referrer, notice: "You order only one restaurant at a time" }
        end
      end
    else
      respond_to do |format|
        format.json { render json: { message: 'No Restaurant Dish Available' } }
        format.html { redirect_to request.referrer, notice: "No Restaurant Dish Available" }
      end
    end
  end

  def create
    cart_item = @cart.cart_items.find_by(restaurant_dish_id: params[:restaurant_dish_id])
    # if cart_item exist then update its quantity
    if cart_item
      output = {}
      output[:message]
      output[:data] = cart_item if cart_item.update_quantity(params[:quantity].to_i)
      respond_to do |format|
        format.json {
          if output[:data]
            render json: output
          else
            render json: nil
          end
        }
        format.html { redirect_to request.referrer, notice: "Update Successfully" }
      end
      return
    end

    cart_item = @cart.cart_items.new(items_params)
    if cart_item.save
      respond_to do |format|
        format.json  { render json: cart_item }
        format.html { redirect_to request.referrer, notice: "Added Successfully" }
      end
    else
      @cart.cart_items.delete(cart_item)
      destroy_cart_if_empty
      respond_to do |format|
        format.json { render status: :unprocessable_entity, json: { message: cart_item.errors.full_messages } }
        format.html { redirect_to request.referrer, notice: cart_item.errors.full_messages }
      end
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @cart_item }
      format.html
    end
  end

  def update
    if @cart_item.update(quantity: params[:cart_item][:quantity])
      respond_to do |format|
        format.json { render json: @cart_item }
        format.html { redirect_to request.referrer, notice: "Update Successfully" }
      end
    else
      respond_to do |format|
        format.json { render status: :unprocessable_entity, json: { errors: @cart_item.errors.full_messages } }
        format.html { redirect_to request.referrer, notice: @cart_item.errors.full_messages }
      end
    end
  end

  def destroy
    @cart_item.destroy
    destroy_cart_if_empty
    respond_to do |format|
      format.json { render status: :ok, json: 'Item removed from cart' }
      format.html { redirect_to request.referrer, notice: "Remove Successfully" }
    end
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
