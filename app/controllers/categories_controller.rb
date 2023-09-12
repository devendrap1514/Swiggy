class CategoriesController < AuthenticationController
  before_action :is_owner?, except: %i[index show]

  def index
    render json: Category.all
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: category
    else
      render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    category = Category.find_by_id(params[:_category_id])
    if category
      # render json: category
      render json: {
        Dish: ActiveModelSerializers::SerializableResource.new(category, {serializer: CategorySerializer}).as_json,
        Dishes: ActiveModel::Serializer::CollectionSerializer.new(category.dishes, each_serializer: DishSerializer)
      }
    else
      render json: 'no such category'
    end
  end

  def update
    category = Category.find_by_id(params[:_category_id])
    if category
      if category.update(category_params)
        render json: category
      else
        render json: { errors: "error while deleting" }
      end
    else
      render json: 'no such category'
    end
  end

  private
    def category_params
      params.permit(:category_name)
    end
end
