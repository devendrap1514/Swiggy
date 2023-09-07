class RestaurantDishesController < AuthenticationController
  before_action :is_owner?, except: %i[index show]

  def index
    render json: RestaurantDish.all, include: ['dish.category', 'restaurant']
  end

  def create
    rd = RestaurantDish.new(rd_params)
    if rd.save
      render json: rd
    else
      render json: { errors: rd.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    rd = RestaurantDish.find_by_id(params[:_restaurant_dish_id])
    if rd
      if rd.update(rd_params)
        render json: rd
      else
        render json: { errors: rd.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: "no such Restaurant Dish"
    end
  end

  def destroy
    rd = RestaurantDish.find_by_id(params[:_restaurant_dish_id])
    if rd
      if rd.destroy
        render json: rd
      else
        render json: { errors: "error while deleting" }
      end
    else
      render json: "no such Restaurant Dish"
    end
  end

  private
    def rd_params
      params.permit(:restaurant_id, :dish_id, :price)
    end
end
