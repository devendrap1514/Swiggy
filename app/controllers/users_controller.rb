class UsersController < ApplicationController
  before_action :authorize_request, except: %i[create login]
  authorize_resource except: %i[login create]

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

  private

  def login_params
    params.permit(:username, :password)
  end

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation, :profile_picture)
  end
end
