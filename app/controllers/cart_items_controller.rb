class CartItemsController < AuthenticationController
  before_action :is_customer?
  def create
    restaurant_dish = RestaurantDish.find_by_id(params[:restaurant_dish_id])
    if restaurant_dish
      cart_item = @current_user.cart.cart_items.new(items_params)
      dish_price = restaurant_dish.price
      cart_item.price = dish_price * params[:quantity].to_i
      if cart_item.save
        render json: cart_item
      else
        render status: :unprocessable_entity,
                json: { errors: cart_item.errors.full_messages }
      end
    else
      render status: :not_found, json: 'No restaurant dish found'
    end
  end

  def destroy
    cart_item = @current_user.cart.cart_items.find_by_id(params[:_cart_item_id])
    if cart_item
      cart_item.destroy
      render status: :ok,
              json: 'Item removed from cart'
    else
      render status: :not_found,
              json: 'no such cart item is present in cart'
    end
  end

  private
    def items_params
      params.permit(:restaurant_dish_id, :quantity)
    end
end
