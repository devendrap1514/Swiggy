class RestaurantsController < AuthenticationController
  before_action :is_owner?, except: %i[index show]
  before_action :find_restaurant, only: %i[show update destroy]

  def index
    if params[:status].nil?
      render json: Restaurant.all.page(params[:page])
    elsif ['open', 'close'].include? params[:status]
      render json: Restaurant.where(status: params[:status]).page(params[:page])
    else
      render json: {
        message: 'wrong status value, value must be opne or close'
      }
    end
  end

  def create
    @restaurant = @current_user.restaurants.new(restaurant_params)
    if @restaurant.save
      render json: @restaurant
    else
      render status: :unprocessable_entity,
              json: { errors: @restaurant.errors.full_messages }
    end
  end

  def show
      render json: @restaurant
  end

  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @restaurant.destroy
      render json: @restaurant
    else
      render json: { errors: "error while deleting" }
    end
  end

  def find_restaurant
    # Get only user restaurants
    @restaurant = @current_user.restaurants.find_by_id(params[:_restaurant_id])
    unless @restaurant
      render json: 'no such restaurant'
    end
  end

  private
    def restaurant_params
      params.permit(:restaurant_name, :address, :status)
    end
end
