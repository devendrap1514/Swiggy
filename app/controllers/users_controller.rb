class UsersController < ApplicationController
  before_action :authorize_request, except: %i[create login forgot_password reset_password]
  authorize_resource except: %i[login create forgot_password reset_password]

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

  def login
    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render status: :ok, json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'),
                                  username: @user.username }
      response.headers['Token'] = token
    else
      render status: :unauthorized, json: { error: 'unauthorized' }
    end
  end

  def forgot_password
    return render json: 'Username must be pass' unless params[:username]

    user = User.find_by_username(params[:username])
    if user.present?
      user.generate_password_token! # generate pass token
      UserMailer.with(user:).forgot_password_token.deliver_now
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
        render status: :unprocessable_entity, json: { error: user.errors.full_messages }
      end
    else
      render status: :not_found, json: { error: ['Link not valid or expired. Try generating a new link.'] }
    end
  end

  private

  def login_params
    params.permit(:username, :password)
  end

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation, :profile_picture)
  end
end
