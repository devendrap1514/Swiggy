class OwnersController < UsersController
  def create
    @owner = Owner.new(user_params)
    if @owner.save
      render json: @owner, status: :created
    else
      render json: { errors: @owner.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def my_restaurant
    render json: @user.restaurants
  end

  def my_dishes
    render json: @user.restaurants.joins(:dishes).pluck(:dish_name)
  end
end
