class OwnersController < UsersController
  def create
    owner = Owner.new(user_params)
    if owner.save
      render json: owner, status: :created
    else
      render status: :unprocessable_entity,
              json: { errors: owner.errors.full_messages }
    end
  end

  def my_restaurant
    render json: @current_user.restaurants.page(params[:page])
  end

  def my_dishes
    dishes = Dish.joins(:restaurants).where("restaurants.user_id = #{@current_user.id}").filter_by_dish_name(params[:dish]).filter_by_category(params[:category]).filter_by_restaurant_name(params[:restaurant_name]).page(params[:page])
    render json: dishes
  end
end
