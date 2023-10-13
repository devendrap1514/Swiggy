class UserAuthenticationsController < ApplicationController
  def new
    @user_authentication = UserAuthentication.new
  end

  def create
    @user_authentication = UserAuthentication.new(user_authentication_params)
    if @user_authentication.is_valid_password?
      # token = JsonWebToken.encode(user_id: @user.id)
      # session[:token] = token
      redirect_to "www.google.com"
    else
      render :new
    end
  end

  private
  def user_authentication_params
    params.require(:user_authentication).permit(:username, :password)
  end
end
