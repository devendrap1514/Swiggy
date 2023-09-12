class RestaurantsController < AuthenticationController
  before_action :is_owner?, except: %i[index show]

  def index

    if params[:status].nil?
      render json: Restaurant.all
    elsif ['open', 'close'].include? params[:status]
      render json: Restaurant.where(status: params[:status])
    else
      render json: {
        message: 'wrong status value value must be opne or close'
      }
    end
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
    restaurant = Restaurant.find_by_id(params[:_restaurant_id])
    if restaurant
      render json: restaurant
    else
      render json: 'no such restaurant'
    end
  end

  def update
    restaurant = Restaurant.find_by_id(params[:_restaurant_id])
    if restaurant
      if restaurant.update(restaurant_params)
        render json: restaurant
      else
        render json: restaurant, status: :unprocessable_entity
      end
    else
      render json: 'no such restaurant'
    end
  end

  def destroy
    restaurant = Restaurant.find_by_id(params[:_restaurant_id])
    if restaurant
      if restaurant.destroy
        render json: restaurant
      else
        render json: { errors: "error while deleting" }
      end
    else
      render json: 'no such restaurant'
    end
  end

  private
    def restaurant_params
      params.permit(:restaurant_name, :address, :status)
    end
end
