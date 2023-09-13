class SearchesController < AuthenticationController
  def search_by_restaurant
    restaurant = params[:restaurant].squeeze(" ").strip unless params[:restaurant].nil?
    unless params[:restaurant].nil?
      render json: Restaurant.filter_by_name(restaurant).page(params[:page])
    else
      render json: Restaurant.all.page(params[:page])
    end
  end

  def search_by_category
    category = params[:category].squeeze(" ").strip unless params[:category].nil?
    unless category.nil?
      render json: Dish.joins(:category).where("category_name LIKE '#{category}'").page(params[:page])
    else
      render json: Dish.all.page(params[:page])
    end
  end

  def search_by_dish
    dish = params[:dish].squeeze(" ").strip unless params[:dish].nil?
    unless dish.nil?
      render json: Dish.joins(:restaurants).where("dish_name LIKE '%#{dish}%'").page(params[:page])
    else
      render json: Dish.joins(:restaurants).page(params[:page])
    end
  end
end
