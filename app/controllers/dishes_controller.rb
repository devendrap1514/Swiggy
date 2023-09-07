class DishesController < AuthenticationController
  before_action :find_owner, except: %i[index show]

  def index
    render json: Dish.all
  end

  def create
    dish = Dish.new(dish_params)
    if dish.save
      render json: dish
    else
      render json: { errors: dish.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    dish = Dish.find_by_dish_name(params[:_dish_name])
    if dish
      render json: dish
    else
      render json: 'no such dish'
    end
  end

  def update
    dish = Dish.find_by_dish_name(params[:_dish_name])
    if dish
      if dish.update(dish_params)
        render json: dish
      else
        render json: nil, status: :unprocessable_entity
      end
    else
      render json: 'no such dish'
    end
  end

  def destroy
    dish = Dish.find_by_dish_name(params[:_dish_name])
    if dish
      if dish.destroy
        render json: dish
      else
        render json: nil, status: :unprocessable_entity
      end
    else
      render json: 'no such dish'
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

    def dish_params
      params.permit(:dish_name, :category_id)
    end
end
