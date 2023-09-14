class ApplicationController < ActionController::API
  rescue_from CanCan::AccessDenied do |exception|
    render json: exception.message
  end

  before_action :authorize_request

  def not_found
    render json: { errors: 'No such routes' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render status: :unauthorized, json: { errors: e.message }
    rescue JWT::DecodeError => e
      render status: :unauthorized, json: { errors: e.message }
    end
  end

  # CanCan expects a current_user method to exist in the controller.
  attr_reader :current_user
end
