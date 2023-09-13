class RestaurantsController < AuthenticationController
  before_action :is_owner?, except: %i[index show restaurant_dishes]
  before_action :find_restaurant, only: %i[show update destroy restaurant_dishes]

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
    if is_restaurant_owner?
      if @restaurant.update(restaurant_params)
        render json: @restaurant
      else
        render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render status: :unauthorized, json: "Not authorized"
    end
  end

  def destroy
    if is_restaurant_owner?
      begin
        @restaurant.destroy
        render json: "Deleted Successfully"
      rescue Exception => e
        render status: :internal_server_error, json: e.message
      end
    else
      render status: :unauthorized, json: "Not authorized"
    end
  end

  def is_restaurant_owner?
    @restaurant.user_id == @current_user.id
  end

  def find_restaurant
    @restaurant = Restaurant.find_by_id(params[:_restaurant_id])
    unless @restaurant
      render status: :not_found,
              json: 'no such restaurant'
    end
  end

  def restaurant_dishes
    render json: @restaurant.dishes
  end

  private
    def restaurant_params
      params.permit(:restaurant_name, :address, :status)
    end
end
