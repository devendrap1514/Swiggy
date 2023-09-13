class SearchesController < AuthenticationController
  def search_by_restaurant
    unless params[:restaurant].nil?
      render json: Restaurant.where("restaurant_name LIKE '%#{params[:restaurant]}%'").page(params[:page])
    else
      render json: Restaurant.all.page(params[:page])
    end
  end

  def search_by_category
    # byebug
    unless params[:category].nil?
      render json: Dish.joins(:category).where("category_name LIKE '#{params[:category]}'").page(params[:page])
    else
      render json: Dish.all.page(params[:page])
    end
  end

  def search_by_dish
    unless params[:dish].nil?
      render json: Dish.joins(:restaurants).where("dish_name LIKE '%#{params[:dish]}%'").page(params[:page])
    else
      render json: Dish.joins(:restaurants).page(params[:page])
    end
  end
end
