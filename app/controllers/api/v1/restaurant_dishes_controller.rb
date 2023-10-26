class Api::V1::RestaurantDishesController < Api::V1::ApiController
  before_action :find_restaurant_dish, only: %i[show edit update destroy]

  def index
    q = StripAndSqueeze.apply(params[:q])
    @restaurant_dishes = unless q.empty?
               RestaurantDish.filter_by_search(q)
             else
               RestaurantDish.all
             end

    @restaurant_dishes = @restaurant_dishes.page(params[:page])
    respond_to do |format|
      format.json { render json: @restaurant_dishes.page(params[:page]) }
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
    respond_to do |format|
      format.json { render json: @restaurant_dish }
      format.html {  }
    end
  end

  def edit
  end

  def update
    if @restaurant_dish.update(restaurant_dish_params)
      respond_to do |format|
        format.json { render json: @restaurant_dish }
        format.html { redirect_to [:api, :v1, @restaurant_dish]  }
      end
    else
      respond_to do |format|
        format.json { render status: :unprocessable_entity, json: { message: @restaurant_dish.errors.full_messages } }
        format.html { render :edit }
      end
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
    params.require(:restaurant_dish).permit(:restaurant_id, :dish_id, :price)
  end
end
