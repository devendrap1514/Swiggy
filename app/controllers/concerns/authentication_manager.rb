module AuthenticationManager
  extend ActiveSupport::Concern

  def login
    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      session[:token] = token
      render json: { message: "Successfully Login", token: token }
    else
      render status: :unauthorized, json: { error: "username & possword doesn't match" }
    end
  end

  def logout
    session.delete(:token)
    render status: :ok, json: "Successfully Logout"
  end
end
