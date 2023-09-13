class OwnersController < UsersController
  def create
    create_user("Owner")
  end

  def my_restaurant
    render json: @current_user.restaurants.page(params[:page])
  end

  def my_dishes
    if params[:category].nil? and params[:dish].nil?
      dishes = Dish.joins(:restaurants, :category).where("restaurants.user_id = #{@current_user.id}").page(params[:page])
      render json: dishes
    elsif params[:dish]
      dishes = Dish.joins(:restaurants, :category).where("restaurants.user_id = #{@current_user.id} and dishes.dish_name LIKE '#{params[:dish]}'").page(params[:page])
      render json: dishes
    elsif params[:category]
      dishes = Dish.joins(:restaurants, :category).where("restaurants.user_id = #{@current_user.id} and categories.category_name LIKE '#{params[:category]}'").page(params[:page])
      render json: dishes
    end
  end
end
