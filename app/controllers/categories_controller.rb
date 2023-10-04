class CategoriesController < ApiController
  before_action :set_category

  def index
    render status: :ok,
           json: Category.all
  end

  def show
    render json: @category
  end

  def category_dishes
    render json: @category.dishes.page(params[:page])
  end

  private

  def category_params
    params.permit(:category_name)
  end

  def set_category
    @category = Category.find_by_id(params[:id])
    unless @category
      render status: :not_found,
             json: 'no such category'
    end
  end
end
