class OwnersController < UsersController
  def create
    create_user("Owner")
  end

  def my_restaurant
    render json: @current_user.restaurants
  end

  def my_dishes
    byebug
    if params[:category].nil?
      dishes = Dish.joins(:restaurants, :category).where("restaurants.user_id = #{@current_user.id}").page(params[:page])
      render json: dishes
    else
      dishes = Dish.joins(:restaurants, :category).where("restaurants.user_id = #{@current_user.id} and categories.category_name LIKE '#{params[:category]}'").page(params[:page])
      render json: dishes

    end
  end
end
