class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render status: :ok, json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                      username: @user.username }
                      response.headers["Token"] = token
    else
      render status: :unauthorized, json: { error: 'unauthorized' }
    end
  end

  def is_owner?
    @user = @current_user
    p "-------------------------------.\n\n\n",@user
    unless @user.type == 'Owner'
      render status: :ok, json: { error: 'You ara not a Owner' }
    end
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: { errors: 'Owner not found' }
  end

  def is_customer?
    @user = @current_user
    unless @user.type == 'Customer'
      render status: :ok, json: { error: 'You ara not a Customer' }
    end
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: { errors: 'Customer not found' }
  end

  private
    def login_params
      params.permit(:username, :password)
    end
end
