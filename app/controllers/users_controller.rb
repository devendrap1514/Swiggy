class UsersController < ApiController
  include PasswordManager
  include AuthenticationManager

  #---------don't use before_action bcz it will not execute authorize_request before authorise_resource
  skip_before_action :authorize_request, only: %i[create login logout forgot_password reset_password]

  def create(user)
    UserMailer.with(user: user).welcome_email.deliver_now
  end

  def show
    render json: { message: "Success", data: @current_user }
  end

  def update
    if @current_user.update(user_params)
      render json: { message: "Update Successfully", data: @current_user }
    else
      render status: :unprocessable_entity,
             json: { message: @current_user.errors.full_messages }
    end
  end

  def destroy
    @current_user.destroy
    render status: :ok, json: { message:'Deleted Successfully' }
  rescue Exception => e
    render status: :internal_server_error, json: { messages: e.message }
  end

  private

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation, :profile_picture)
  end
end
