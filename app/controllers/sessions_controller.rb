class SessionsController < ApplicationController
  before_action :authorize_request, if: :is_login?
  skip_before_action :authorize_request, only: %i[login login_create forgot_password reset_password]

  def welcome_page
    unless is_login?
      render 'new'
    end
  end

  def new
  end

  def create
    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render status: :ok, json: { message: "Successfully Login", username: @user.username }
      session[:token] = token
    else
      render status: :unauthorized, json: { error: 'unauthorized' }
    end
  end

  def destroy
    session[:token].delete
    render json: "Logout Successfully"
  end

  def forgot_password
    return render json: 'Username must be pass' unless params[:username]

    user = User.find_by_username(params[:username])
    if user.present?
      user.generate_password_token! # generate pass token
      UserMailer.with(user:user).forgot_password_token.deliver_now
      render json: 'Email Send Successfully'
    else
      render json: { error: ['Username not found. Please check and try again.'] }, status: :not_found
    end
  end

  def reset_password
    token = params[:token]

    return render json: { error: 'Token not present' } unless token

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: 'Password Update Successfully'
      else
        render status: :unprocessable_entity, json: { errors: user.errors.full_messages }
      end
    else
      render status: :not_found, json: { error: ['Link not valid or expired. Try generating a new link.'] }
    end
  end

  # private
  # def login_params
  #   params.permit(:username, :password)
  # end
end
