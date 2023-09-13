class UsersController < AuthenticationController
  before_action :authorize_request, except: [:create]
  before_action :check_username_with_token, except: %i[create index]

  def index
    render json: User.all
  end

  def create_user(type)
    user = nil
    if type == "Owner"
      user = Owner.new(user_params)
    elsif type == "Customer"
      user = Customer.new(user_params)
    end

    if user.save
      render json: user, status: :created
    else
      render status: :unprocessable_entity,
              json: { errors: user.errors.full_messages }
    end
  end

  def show
    render json: @current_user
  end

  def update
    if @current_user.update(user_params)
      render json: @current_user
    else
      render status: :unprocessable_entity,
              json: { errors: @current_user.errors.full_messages }
    end
  end

  def destroy
    begin
      @current_user.destroy
      render json: "Deleted Successfully"
    rescue Exception => e
      render status: :internal_server_error,
              json: e.message
    end
  end

  private
    def check_username_with_token
      # to know which username get and what is the current user username
      unless params[:_username] == @current_user.username
        render status: :bad_request,
                json: { errors: 'bad_request' }
      end
    rescue ActiveRecord::RecordNotFound
      render status: :not_found,
              json: { errors: 'User not found' }
    end

    def user_params
      params.permit(:name, :username, :password, :password_confirmation, :profile_picture)
    end
end
