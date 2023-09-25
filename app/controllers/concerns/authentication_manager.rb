module AuthenticationManager
  extend ActiveSupport::Concern

  def login
    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      session[:token] = token
      render json: "Successfully Login"
    else
      render status: :unauthorized, json: { error: 'unauthorized' }
    end
  end

  def logout
    session.delete(:token)
    render json: "Successfully Logout"
  end
end
