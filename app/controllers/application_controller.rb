class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :username, :type, :email, :password, :password_confirmation, :profile_picture)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :username, :email, :password, :password_confirmation, :profile_picture)}
  end
end
