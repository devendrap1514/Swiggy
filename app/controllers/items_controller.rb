class ItemsController < AuthenticationController
  before_action :is_customer?
  def create
    item = @current_user.cart.items.new(items_params)
    if item.save
      render json: item
    else
      render status: :unprocessable_entity,
              json: { errors: item.errors.full_messages }
    end
  end

  def destroy
    item = @current_user.cart.items.find_by_id(params[:_item_id])
    if item
      item.destroy
      render status: :ok,
              json: 'Item removed from cart'
    else
      render status: :not_found,
              json: 'no such item is present in cart'
    end
  end

  private
    def items_params
      params.permit(:restaurant_dish_id, :quantity)
    end
end
