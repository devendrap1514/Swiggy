class RestaurantsController < ApplicationController
  before_action :authorize_request
  before_action :find_owner, except: %i[index, show]

  def index
    render json: Restaurant.all
  end

  def create
    restaurant = @user.restaurants.new(restaurant_params)
    if restaurant.save
      render json: restaurant
    else
      render json: { errors: restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    restaurant = Restaurant.find_by_restaurant_name(params[:_restaurant_name])
    if restaurant
      render json: restaurant
    else
      render json: 'no such restaurant'
    end
  end

  def update
    restaurant = Restaurant.find_by_restaurant_name(params[:_restaurant_name])
    if restaurant
      if restaurant.update(restaurant_params)
        render json: restaurant
      else
        render json: nil, status: :unprocessable_entity
      end
    else
      render json: 'no such restaurant'
    end
  end

  def destroy
    restaurant = Restaurant.find_by_restaurant_name(params[:_restaurant_name])
    if restaurant
      if restaurant.destroy
        render json: restaurant
      else
        render json: nil, status: :unprocessable_entity
      end
    else
      render json: 'no such restaurant'
    end
  end

  private
    def find_owner
      @user = @current_user
      unless @user.type == 'Owner'
        render json: { error: 'You ara not a Owner' }
      end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
    end

    def restaurant_params
      params.permit(:restaurant_name, :address, :status)
    end
end
