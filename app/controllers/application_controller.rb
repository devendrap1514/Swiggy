class ApplicationController < ActionController::API
  rescue_from CanCan::AccessDenied do |exception|
    render json: exception.message
  end

  before_action :authorize_request, if: :is_login?
  authorize_resource

  def not_found
    render json: { errors: 'No such routes' }
  end

  def authorize_request
    unless session[:token]
      return render json: "First Login"
    end
    begin
      @decoded = JsonWebToken.decode(session[:token])
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render status: :unauthorized, json: { errors: e.message }
    rescue JWT::DecodeError => e
      render status: :unauthorized, json: { errors: e.message }
    end
  end

  def is_login?
    return true if session[:token]
    false
  end

  # CanCan expects a current_user method to exist in the controller.
  attr_reader :current_user
end
