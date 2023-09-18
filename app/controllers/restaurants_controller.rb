class RestaurantsController < ApplicationController
  before_action :find_current_user_restaurant, only: %i[update destroy]
  before_action :find_restaurant, only: %i[show restaurant_dishes]
  authorize_resource

  def index
    restaurants = if params[:status].present?
                    Restaurant.send(params[:status].to_s.downcase)
                  else
                    Restaurant.all
                  end

    restaurant_name = StripAndSqueeze.apply(params[:restaurant_name])
    restaurants = restaurants.filter_by_restaurant_name(restaurant_name).page(params[:page])
    render json: restaurants
  rescue Exception => e
    render status: :internal_server_error, json: { message: 'Status value in (open, close)', error: e.message }
  end

  def create
    @restaurant = @current_user.restaurants.new(restaurant_params)
    if @restaurant.save
      render json: @restaurant
    else
      render status: :unprocessable_entity,
             json: { errors: @restaurant.errors.full_messages }
    end
  rrescue Exception => e
    render status: :internal_server_error, json: { message: 'Status value in (open, close)', error: e.message }
  end

  def show
    render json: @restaurant
  end

  def update
    if @current_user_restaurant.update(restaurant_params)
      render json: @current_user_restaurant
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @current_user_restaurant.destroy
    render json: 'Deleted Successfully'
  rescue Exception => e
    render status: :internal_server_error, json: e.message
  end

  def find_current_user_restaurant
    @current_user_restaurant = @current_user.restaurants.find_by_id(params[:id])
    render status: :not_found, json: 'no such restaurant' unless @current_user_restaurant
  end

  def find_restaurant
    @restaurant = Restaurant.find_by_id(params[:id])
    return if @restaurant

    render status: :not_found,
           json: 'no such restaurant'
  end

  def restaurant_dishes
    dish_name = StripAndSqueeze.apply params[:dish_name]
    render json: @restaurant.dishes.filter_by_dish_name(dish_name).page(params[:page])
  end

  private

  def restaurant_params
    params.permit(:restaurant_name, :address, :status)
  end
end
