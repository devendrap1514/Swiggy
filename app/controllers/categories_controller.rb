class CategoriesController < AuthenticationController
  before_action :find_owner, except: %i[index show]

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
    category = Category.find_by_category_name(params[:_category_name])
    if category
      render json: category
    else
      render json: 'no such category'
    end
  end

  def update
    category = Category.find_by_category_name(params[:_category_name])
    if category
      if category.update(category_params)
        render json: category
      else
        render json: nil, status: :unprocessable_entity
      end
    else
      render json: 'no such category'
    end
  end

  def destroy
    category = Category.find_by_category_name(params[:_category_name])
    if category
      if category.destroy
        render json: category
      else
        render json: nil, status: :unprocessable_entity
      end
    else
      render json: 'no such category'
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

    def category_params
      params.permit(:category_name)
    end
end
