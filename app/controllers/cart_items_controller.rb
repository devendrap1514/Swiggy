class CartItemsController < ApplicationController
  authorize_resource
  def create
    cart_item = @current_user.cart.cart_items.new(items_params)
    if cart_item.save
      render json: cart_item
    else
      render status: :unprocessable_entity,
             json: { errors: cart_item.errors.full_messages }
    end
  end

  def destroy
    cart_item = @current_user.cart.cart_items.find_by_id(params[:id])
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
