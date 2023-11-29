class Api::V1::RestaurantsController < Api::V1::ApiController
  before_action :find_current_user_restaurant, only: %i[edit update destroy]
  before_action :find_restaurant, only: %i[show restaurant_dishes]

  def index
    @restaurants = Restaurant.all
    @restaurants = if params[:status].present?
                    if params[:status] == "all"
                      Restaurant.all
                    else
                      begin
                        # occur error if wrong status get
                        Restaurant.send(params[:status].to_s.downcase)
                        # otherwise
                        Restaurant.where(restaurants: {status: "#{params[:status]}"})
                      rescue
                        Restaurant.all
                      end
                    end
                  else
                    Restaurant.all
                  end

    restaurant_name = StripAndSqueeze.apply(params[:q])
    @restaurants = @restaurants.filter_by_restaurant_name(restaurant_name).page(params[:page])
    respond_to do |format|
      format.json { render json: @restaurants }
      format.html
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    if @restaurant.save
      respond_to do |format|
        format.json { render json: @restaurant }
        format.html { redirect_to api_v1_restaurants_path }
      end
    else

      respond_to do |format|
        format.json { render status: :unprocessable_entity, json: { message: @restaurant.errors.full_messages } }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  rescue Exception => e
    respond_to do |format|
      format.json { render status: :internal_server_error, json: { message: 'Status value in (open, close)', error: e.message } }
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  def show
    respond_to do |format|
      format.json { render status: :ok, json: @restaurant }
      format.html
    end
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      respond_to do |format|
        format.json { render json: @restaurant }
        format.html { redirect_to api_v1_restaurant_path(@restaurant) }
      end
    else
      respond_to do |format|
        format.json { render json: { message: @restaurant.errors.full_messages }, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.json { render status: :ok, json: 'Deleted Successfully' }
      format.html { redirect_to api_v1_restaurants_path }
    end
  rescue Exception => e
    render status: :internal_server_error, json: { message: e.message }
  end

  def find_current_user_restaurant
    @restaurant = current_user.restaurants.find_by_id(params[:id])
    respond_to do |format|
      format.json { render status: :not_found, json: 'no such restaurant' unless @restaurant }
      format.html
    end
  end

  def find_restaurant
    @restaurant = Restaurant.find_by_id(params[:id])
    return if @restaurant

    respond_to do |format|
      format.json { render status: :not_found, json: 'no such restaurant' }
      format.html { redirect_to "/not_found" }
    end
  end

  def restaurant_dishes
    dish_name = StripAndSqueeze.apply params[:dish_name]
    @dishes = @restaurant.dishes.filter_by_dish_name(dish_name).page(params[:page])
    output = {}
    output[:message] = "Successfully"
    output[:data] = ActiveModelSerializers::SerializableResource.new(@dishes, each_serializer: DishSerializer)
    respond_to do |format|
      format.json { render json:  }
      format.html
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:restaurant_name, :address, :status)
  end
end
