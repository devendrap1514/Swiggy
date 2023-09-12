class CategoriesController < AuthenticationController
  before_action :is_owner?, except: %i[index show]

  def index
    render status: :ok,
           json: Category.all
  end

  def create
    category = Category.new(category_params)
    if category.save
      render status: :created,
             json: category
    else
      render status: :unprocessable_entity,
             json: { errors: category.errors.full_messages }
    end
  end

  def show
    category = Category.find_by_id(params[:_category_id])
    if category
      render status: :ok,
             json: category
      # render json: {
      #   Dish: ActiveModelSerializers::SerializableResource.new(category, {serializer: CategorySerializer}).as_json,
      #   Dishes: ActiveModel::Serializer::CollectionSerializer.new(category.dishes, each_serializer: DishSerializer)
      # }
    else
      render status: :not_found,
            json: 'no such category'
    end
  end

  def update
    category = Category.find_by_id(params[:_category_id])
    if category
      if category.update(category_params)
        render status: :ok,
               json: category
      else
        render status: :internal_server_error,
               json: { errors: "error while deleting" }
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
