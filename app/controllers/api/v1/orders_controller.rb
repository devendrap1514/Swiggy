class Api::V1::OrdersController < Api::V1::ApiController
  before_action :find_order, only: %i[show destroy payment create_payment]

  def index
    @orders = current_user.orders
    output = {}
    output[:message] = "success"
    output[:data] = ActiveModelSerializers::SerializableResource.new(@orders, each_serializer: OrderSerializer)
    respond_to do |format|
      format.json { render status: :ok, json: output }
      format.html {  }
    end
  end

  def new
    unless current_user.cart.present?
      redirect_to root_path
    end and return
    @order = Order.new
  end

  def create
    if current_user.cart.present?
      cart_items = current_user.cart.cart_items

      unless restaurant_open(cart_items)
        respond_to do |format|
          format.json {
            output = {}
            output[:message] = "Restaurant must be open"
            render json: output
          }
          format.html { redirect_to request.referrer, notice: "Restaurant must be open" }
        end and return
      end

      @order = current_user.orders.new(order_params)

      if @order.save
        ActiveRecord::Base.transaction do
          cart_items.each do |item|
            @order.order_items.create(
              restaurant_dish_id: item.restaurant_dish_id,
              quantity: item.quantity,
              price: item.price
            )
          end
        end
      else
        render :new
        return
      end

      begin
        respond_to do |format|
          format.json {
            output = {}
            output[:message] = "success"
            output[:message] = OrderSerializer.new @order
            render json: output
          }
          format.html { redirect_to "#{payment_api_v1_order_path(@order)}" }
        end and return
        return
      rescue Exception => e
        render status: :internal_server_error, json: { message: e.message }
      end

    else
      render status: :not_found, json: { message: "Cart is empty" }
    end
  rescue Exception => e
    @order.destroy
    render json: {message: "Oops. Order not placed #{e.message}"}
  end

  def show
    output = {}
    output[:message] = "success"
    output[:data] = @order
    respond_to do |format|
      format.json { render json: output }
      format.html { redirect_to api_v1_order_order_items_path(@order) }
    end
  end

  def destroy
    @order.destroy
    render json: {message: 'Order deleted successfully'}
  rescue Exception => e
    render status: :internal_server_error, json: {message: e.message}
  end

  def restaurant_open(cart_items)
    return false unless cart_items[0].restaurant_dish.restaurant.status == "open"
    true
  end

  def payment
    if @order.payment_status == "payment_confirmed"
      redirect_to api_v1_order_order_items_path(@order)
    end
  end

  def create_payment
    if @order.update(razorpay_payment_id: params[:razorpay_payment_id], payment_status: "payment_confirmed")
      current_user.cart.destroy  # destroy_cart_item
      redirect_to api_v1_order_order_items_path(@order)
    else
      render :payment
    end
  end

  def create_order(cart_items)
    ActiveRecord::Base.transaction do
      @order = current_user.orders.create
      cart_items.each do |item|
        @order.order_items.create(
          restaurant_dish_id: item.restaurant_dish_id,
          quantity: item.quantity,
          price: item.price
        )
      end
    end
    @order
  rescue Exception => e
    render json: {message: 'Oops. Order not placed'}
  end

  def find_order
    @order = current_user.orders.find_by_id(params[:id])
    return if @order

    respond_to do |format|
      format.json { render status: :not_found, json: {message: 'Order not found'} }
      format.html { redirect_to "/not_found" }
    end
  end


  private

  def order_params
    params.require(:order).permit(:name, :phone_number, :address, :order_status, :payment_status)
  end
end
