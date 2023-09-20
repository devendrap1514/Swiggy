class OwnersController < UsersController
  def create
    owner = Owner.new(user_params)
    if owner.save
      render json: owner, status: :created
    else
      return render status: :unprocessable_entity,
             json: { errors: owner.errors.full_messages }
    end
    super(owner)
  end

  def my_restaurant
    render json: @current_user.restaurants.page(params[:page])
  end

  def my_dishes
    dish_name = StripAndSqueeze.apply(params[:dish_name])
    category_name = StripAndSqueeze.apply(params[:category_name])
    dishes = Dish.joins(:restaurants).where("restaurants.user_id = #{@current_user.id}").filter_by_dish_name(dish_name).filter_by_category_name(category_name).page(params[:page])
    render json: dishes
  end
end
