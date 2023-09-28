class CategoriesController < ApiController
  def index
    render status: :ok,
           json: Category.all
  end

  def show
    category = Category.find_by_id(params[:id])
    if category
      render json: category
    else
      render status: :not_found,
             json: 'no such category'
    end
  end

  private

  def category_params
    params.permit(:category_name)
  end
end
