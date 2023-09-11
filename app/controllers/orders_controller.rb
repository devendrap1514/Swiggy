class OrdersController < AuthenticationController
  before_action :is_customer?

  def index
    render json: Order.all
  end

  def create

  end

  def show

  end

  def destroy

  end
end
