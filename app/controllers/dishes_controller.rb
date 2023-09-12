class DishesController < AuthenticationController
  before_action :is_owner?, except: %i[index show]

  def index
    render json: Dish.all.page(params[:page_number])
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
    dish = Dish.find_by_id(params[:_dish_id])
    if dish
      render json: {
        Dish: ActiveModelSerializers::SerializableResource.new(dish, {serializer: DishSerializer}),
        Restaurant: ActiveModel::Serializer::CollectionSerializer.new(dish.restaurants, each_serializer: RestaurantSerializer)
      }
    else
      render json: 'no such dish'
    end
  end

  def update
    dish = Dish.find_by_id(params[:_dish_id])
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
    dish = Dish.find_by_id(params[:_dish_id])
    if dish
      if dish.destroy
        render json: dish
      else
        render json: { errors: "error while deleting" }
      end
    else
      render json: 'no such dish'
    end
  end

  private
    def dish_params
      params.permit(:dish_name, :category_id, dish_images: [])
    end
end
