module AuthenticationManager
  extend ActiveSupport::Concern

  def login
    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      session[:token] = token

      output = {}
      output[:message] = "Successfully Login"
      output[:token] = token
      render status: :ok, json: output
    else
      output = {}
      output[:message] = "username & possword doesn't match"
      render status: :unauthorized, json: output
    end
  end

  def logout
    session.delete(:token)

    output = {}
    output[:message] = "Successfully Logout"
    render status: :ok, json: output
  end
end
