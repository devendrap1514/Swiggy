class ApiController < ActionController::API
  rescue_from CanCan::AccessDenied do |exception|
    render status: :forbidden, json: exception.message
  end

  before_action :authorize_request
  authorize_resource

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(' ')[1] if header

    unless session[:token]
      return render status: :unauthorized, json: {message: "First Login"}
    end unless token

    begin
      decoded = JsonWebToken.decode(token || session[:token])
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render status: :not_found, json: { message: e.message }
    rescue JWT::DecodeError => e
      render status: :unauthorized, json: { message: e.message }
    end
  end

  # CanCan expects a current_user method to exist in the controller.
  attr_reader :current_user
end
