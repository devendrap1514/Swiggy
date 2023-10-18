class Api::V1::RestaurantDishesController < Api::V1::ApiController
  before_action :find_restaurant_dish, only: %i[show update destroy]

  def index
    restaurant_name = StripAndSqueeze.apply(params[:restaurant_name])
    dish_name = StripAndSqueeze.apply(params[:dish_name])
    output = if params[:restaurant_name]
               Restaurant.filter_by_restaurant_name(restaurant_name)
             elsif params[:dish_name]
               RestaurantDish.filter_by_dish_name(dish_name)
             else
               RestaurantDish.all
             end

    respond_to do |format|
      format.json { render json: output.page(params[:page]) }
      format.html
    end
  end

  def create
    @restaurant_dish = RestaurantDish.new(restaurant_dish_params)
    if @restaurant_dish.save
      render json: @restaurant_dish
    else
      render status: :unprocessable_entity,
             json: { message: @restaurant_dish.errors.full_messages }
    end
  end

  def show
    render json: @restaurant_dish
  end

  def update
    if @restaurant_dish.update(price: params[:price])
      render json: @restaurant_dish
    else
      render status: :unprocessable_entity,
             json: { message: @restaurant_dish.errors.full_messages }
    end
  end

  def destroy
    @restaurant_dish.destroy
    render json: 'Deleted Successfully'
  rescue Exception => e
    render status: :internal_server_error,
           json: { message: e.message }
  end

  def find_restaurant_dish
    @restaurant_dish = RestaurantDish.find_by_id(params[:id])
    return if @restaurant_dish

    render status: :not_found, json: 'No such restaurant dish is available'
  end

  private

  def restaurant_dish_params
    params.permit(:restaurant_id, :dish_id, :price)
  end
end
