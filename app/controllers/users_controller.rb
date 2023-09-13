class UsersController < AuthenticationController
  before_action :authorize_request, except: [:create]

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
    def user_params
      params.permit(:name, :username, :password, :password_confirmation, :profile_picture)
    end
end
