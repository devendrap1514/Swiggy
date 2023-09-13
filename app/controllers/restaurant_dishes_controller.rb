class RestaurantDishesController < AuthenticationController
  before_action :is_owner?, except: %i[index show]

  def index
    render json: RestaurantDish.all, include: ['dish.category', 'restaurant']
  end

  def create
    restaurant_dish = RestaurantDish.new(restaurant_dish_params)
    if restaurant_dish.save
      render json: restaurant_dish
    else
      render status: :unprocessable_entity,
              json: { errors: restaurant_dish.errors.full_messages }
    end
  end

  def update
    restaurant_dish = RestaurantDish.find_by_id(params[:_restaurant_dish_id])
    if restaurant_dish
      if restaurant_dish.update(restaurant_dish_params)
        render json: restaurant_dish
      else
        render status: :unprocessable_entity,
                json: { errors: restaurant_dish.errors.full_messages }
      end
    else
      render status: :not_found,
              json: "no such Restaurant Dish"
    end
  end

  def destroy
    restaurant_dish = RestaurantDish.find_by_id(params[:_restaurant_dish_id])
    if restaurant_dish
      if restaurant_dish.destroy
        render json: restaurant_dish
      else
        render json: { errors: "error while deleting" }
      end
    else
      render status: :not_found,
              json: "no such Restaurant Dish"
    end
  end

  private
    def restaurant_dish_params
      params.permit(:restaurant_id, :dish_id, :price)
    end
end
