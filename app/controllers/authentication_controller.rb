class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                      username: @user.username }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def is_owner?
    @user = @current_user
    unless @user.type == 'Owner'
      render json: { error: 'You ara not a Owner' }
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Owner not found' }, status: :not_found
  end

  def is_customer?
    @user = @current_user
    unless @user.type == 'Customer'
      render json: { error: 'You ara not a Customer' }
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Customer not found' }, status: :not_found
  end

  private
    def login_params
      params.permit(:username, :password)
    end
end
