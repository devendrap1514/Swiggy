class ItemStatusesController < AuthenticationController
  before_action :is_customer?
  def create
    is = @user.cart.item_statuses.create(item_status_params)
    if is.save
      render json: is
    else
      render json: { errors: is.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def item_status_params
      params.permit(:restaurant_dish_id, :quantity)
    end
end
