class Api::V1::DishesController < Api::V1::ApiController
  before_action :find_dish, only: [:show, :edit, :update]

  def index
    dish_name = StripAndSqueeze.apply(params[:q])
    category_name = StripAndSqueeze.apply(params[:category_name])
    @dishes = Dish.filter_by_dish_name(dish_name).filter_by_category_name(category_name).page(params[:page])
    output = {}
    output[:message] = "successfull"
    output[:data] = DishSerializer.new @dishes
    respond_to do |format|
      format.json { render status: :ok, json: output }
      format.html
    end
  end

  def new
    @dish = Dish.new
  end

  def create
    @dish = Dish.new(dish_params)
    if @dish.save
      output = {}
      output[:message] = "success"
      output[:data] = DishSerializer.new @dish
      respond_to do |format|
        format.json { render status: :created, json: output }
        format.html { render :new }
      end
    else
      respond_to do |format|
        format.json { render json: { message: @dish.errors.full_messages }, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  def edit

  end

  def update
    if @dish.update(dish_params)
      respond_to do |format|
        format.json { render json: { message: "success", data: @dish } }
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.json { render json: { message: @dish.errors.full_messages }, status: :unprocessable_entity }
        format.html { render :edit }
      end

    end
  end

  def show
    respond_to do |format|
      format.json { render status: :ok, json: {message: "success", data: @dish} }
      format.html
    end
  end

  def find_dish
    @dish = Dish.find_by_id(params[:id])
    return if @dish


    respond_to do |format|
      format.json { render status: :not_found, json: {message: 'no such dish'} }
      format.html { redirect_to "/not_found" }
    end
  end

  private

  def dish_params
    params.require(:dish).permit(:dish_name, :category_id, dish_images: [])
  end
end
