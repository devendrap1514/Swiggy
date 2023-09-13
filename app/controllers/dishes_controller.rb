class DishesController < AuthenticationController
  before_action :find_dish, only: :show

  def index
    render status: :ok,
           json: Dish.all.page(params[:page])
  end

  def show
    render status: :ok,
            json: @dish
  end

  def find_dish
    @dish = Dish.find_by_id(params[:_dish_id])
    unless @dish
      render status: :not_found,
              json: 'no such dish'
    end
  end
end
