class SearchesController < AuthenticationController
  def search_by_restaurant
    unless params[:restaurant].nil?
      render json: Restaurant.where("restaurant_name LIKE '%#{params[:restaurant]}%'").page(params[:page]).per(2)
    else
      render json: Restaurant.all.page(params[:page]).per(2)
    end
  end

  def search_by_category
    # byebug
    unless params[:category].nil?
      render json: Dish.joins(:category).where("category_name LIKE '#{params[:category]}'").page(params[:page]).per(2)
    else
      render json: Dish.all.page(params[:page]).per(2)
    end
  end

  def seach_dish_by_restaurant
end
