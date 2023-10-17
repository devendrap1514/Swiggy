class Api::V1::CategoriesController < Api::V1::ApiController
  before_action :set_category

  def index
    render status: :ok, json: {message: "success", data: Category.all}
  end

  def show
    render json: {message: "success", data: @category}
  end

  def category_dishes
    render json: {message: "success", data: @category.dishes.page(params[:page])}
  end

  private

  def category_params
    params.permit(:category_name)
  end

  def set_category
    @category = Category.find_by_id(params[:id])
    unless @category
      render status: :not_found, json: {message: 'no such category'}
    end
  end
end
