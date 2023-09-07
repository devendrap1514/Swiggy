class RestaurantDishesController < AuthenticationController
  before_action :find_owner, except: %i[index show]

  def index
    render json: RestaurantDish.joins(:restaurant, :dish)
      .pluck(:restaurant_name, :dish_name, :price, :id)
      .map { |r_name, d_name, price, id| {
        "id": id,
        "Restaurant Name": r_name,
        "Dish Name": d_name,
        "Price:": price
      }
    }
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
        render json: { errors: rd.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: "no such Restaurant Dish"
    end
  end

  private
    def find_owner
      @user = @current_user
      unless @user.type == 'Owner'
        render json: { error: 'You ara not a Owner' }
      end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Owner not found' }, status: :not_found
    end

    def rd_params
      params.permit(:restaurant_id, :dish_id, :price)
    end
end
