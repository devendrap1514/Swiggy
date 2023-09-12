class ApplicationController < ActionController::API

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
      p "\n\n\n\n\n===> #{@current_user}\n\n\n\n\n"
    rescue ActiveRecord::RecordNotFound => e
      render status: :unauthorized, json: { errors: e.message }
    rescue JWT::DecodeError => e
      render status: :unauthorized, json: { errors: e.message }
    end
  end
end
