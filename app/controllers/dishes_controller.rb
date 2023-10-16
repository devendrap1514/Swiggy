class DishesController < ApiController
  before_action :find_dish, only: [:show, :update]

  def index
    dish_name = StripAndSqueeze.apply(params[:dish_name])
    category_name = StripAndSqueeze.apply(params[:category_name])
    render json: Dish.filter_by_dish_name(dish_name).filter_by_category_name(category_name).page(params[:page])
  end

  def create
    dish = Dish.new(dish_params)
    if dish.save
      output = {}
      output[:message] = "success"
      output[:data] = DishSerializer.new dish
      render status: :created, json: output
    else
      render json: { message: dish.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @dish.update(dish_params)
      render json: { message: "success", data: @dish }
    else
      render json: { message: @dish.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render status: :ok, json: {message: "success", data: @dish}
  end

  def find_dish
    @dish = Dish.find_by_id(params[:id])
    return if @dish

    render status: :not_found, json: {message: 'no such dish'}
  end

  private

  def dish_params
    params.permit(:dish_name, :category_id, dish_images: [])
  end
end
