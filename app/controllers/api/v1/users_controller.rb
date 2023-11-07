class Api::V1::UsersController < Api::V1::ApiController

  def show
    output = {}
    output[:message] = "success"
    output[:data] = UserSerializer.new @current_user

    respond_to do |format|
      format.json { render json: output }
      format.html {  }
    end
  end

  def my_restaurant
    render json: { message: "success", data: @current_user.restaurants.page(params[:page]) }
  end

  def my_dishes
    dish_name = StripAndSqueeze.apply(params[:dish_name])
    category_name = StripAndSqueeze.apply(params[:category_name])
    dishes = Dish.joins(:restaurants).where("restaurants.owner_id = #{@current_user.id}").filter_by_dish_name(dish_name).filter_by_category_name(category_name).page(params[:page])
    render json: { message: "success", data: dishes }
  end
end
