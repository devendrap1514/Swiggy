class DishesController < ApplicationController
  before_action :find_dish, only: :show
  authorize_resource
  def index
    dish_name = StripAndSqueeze.apply(params[:dish_name])
    category_name = StripAndSqueeze.apply(params[:category_name])
    render json: Dish.filter_by_dish_name(dish_name).filter_by_category_name(category_name).page(params[:page])
  end

  # def create
  #   dish = Dish.new(dish_params)
  #   if dish.save
  #     render json: dish
  #   else
  #     render json: { errors: dish.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  # def update
  #   dish = Dish.find_by_id(params[:id])
  #   if dish
  #     if dish.update(dish_params)
  #       render json: dish
  #     else
  #       render json: nil, status: :unprocessable_entity
  #     end
  #   else
  #     render json: 'no such dish'
  #   end
  # end

  def show
    render status: :ok,
           json: @dish
  end

  # def destroy
  #   dish = Dish.find_by_id(params[:id])
  #   if dish
  #     if dish.destroy
  #       render json: dish
  #     else
  #       render json: { errors: "error while deleting" }
  #     end
  #   else
  #     render json: 'no such dish'
  #   end
  # end

  def find_dish
    @dish = Dish.find_by_id(params[:id])
    return if @dish

    render status: :not_found,
           json: 'no such dish'
  end

  private

  def dish_params
    params.permit(:dish_name, :category_id)
  end
end
