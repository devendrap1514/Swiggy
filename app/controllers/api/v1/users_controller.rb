class Api::V1::UsersController < Api::V1::ApiController

  before_action :find_user, only: [:show]

  def show
    output = {}
    output[:message] = "success"
    output[:data] = UserSerializer.new @user

    @message = Message.new
    @room_name = get_name(@user, @current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)
    @messages = @single_room.messages

    if @user == @current_user
      respond_to do |format|
        format.html { redirect_to my_profile_api_v1_users_path }
        format.json { render json: output }
      end
    else
      respond_to do |format|
        format.html {  }
        format.json { render json: output }
      end
    end
  end

  def find_user
    @user = User.find_by_id(params[:id])
    unless @user
      respond_to do |format|
        format.html { redirect_to "/not_found" }
        format.json { render "not found" }
      end
    end
  end

  def my_profile

  end

  def my_restaurant
    render json: { message: "success", data: current_user.restaurants.page(params[:page]) }
  end

  def my_dishes
    dish_name = StripAndSqueeze.apply(params[:dish_name])
    category_name = StripAndSqueeze.apply(params[:category_name])
    dishes = Dish.joins(:restaurants).where("restaurants.owner_id = #{current_user.id}").filter_by_dish_name(dish_name).filter_by_category_name(category_name).page(params[:page])
    render json: { message: "success", data: dishes }
  end

  private
  def get_name(user1, user2)
    users = [user1.id, user2.id].sort
    "private_#{users[0]}_#{users[1]}"
  end
end
