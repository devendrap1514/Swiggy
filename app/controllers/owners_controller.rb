class OwnersController < UsersController
  def create
    create_user("Owner")
  end

  def my_restaurant
    render json: @current_user.restaurants
  end

  def my_dishes
    render json: @current_user.restaurants.joins(:dishes).pluck(:dish_name)
  end
end
