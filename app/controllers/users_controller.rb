class UsersController < ApplicationController
  include PasswordManager
  include AuthenticationManager

  before_action :authorize_request, except: %i[create login forgot_password reset_password]

  def create(user)
    UserMailer.with(user: user).welcome_email.deliver_now
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
    @current_user.destroy
    render json: 'Deleted Successfully'
  rescue Exception => e
    render status: :internal_server_error,
           json: e.message
  end

  private

  def login_params
    params.permit(:username, :password)
  end

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation, :profile_picture)
  end
end
