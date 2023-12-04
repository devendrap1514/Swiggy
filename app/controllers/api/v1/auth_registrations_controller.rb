class Api::V1::AuthRegistrationsController < ApplicationController
  def new
    if current_user
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)
    @user.password = Devise.friendly_token[0, 20]
    @user.password_confirmation = @user.password
    if @user.save
      sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      render :new, user: params, status: :unprocessable_entity
    end
  end

  private
  def new_user_params
    params.require(:user).permit(:uid, :provider, :avatar_url, :type, :name, :username, :email, :phone_number, :profile_picture)
  end
end

