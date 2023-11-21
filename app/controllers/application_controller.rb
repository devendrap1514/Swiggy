class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :update_allowed_parameters, if: :devise_controller?

  skip_before_action :verify_authenticity_token

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :username, :type, :email, :mobile, :password, :password_confirmation, :profile_picture)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :username, :email, :mobile, :password, :password_confirmation, :current_password, :profile_picture)}
  end

  def not_found
  end
end
