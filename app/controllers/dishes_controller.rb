class DishesController < AuthenticationController
  before_action :is_owner?, except: %i[index show]
  before_action :find_dish, only: %i[show update destroy]

  def index
    render status: :ok,
           json: Dish.all.page(params[:page])
  end

  def create
    @dish = Dish.new(dish_params)
    if @dish.save
      render status: :ok,
             json: @dish
    else
      render status: :unprocessable_entity,
             json: { errors: @dish.errors.full_messages }
    end
  end

  def show
    render status: :ok,
            json: @dish
  end

  def update
    if @dish.update(dish_params)
      render json: @dish
    else
      render status: :unprocessable_entity,
              json: nil
    end
  end

  def destroy
    if @dish.destroy
      render json: @dish
    else
      render json: { errors: "error while deleting" }
    end
  end

  def find_dish
    @dish = Dish.find_by_id(params[:_dish_id])
    unless @dish
      render status: :not_found,
              json: 'no such dish'
    end
  end

  private
    def dish_params
      params.permit(:dish_name, :category_id, dish_images: [])
    end
end
