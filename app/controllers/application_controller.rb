class ApplicationController < ActionController::Base
  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(' ')[1] if header

    unless session[:token]
      respond_to do |format|
        format.json { render status: :unauthorized, json: {message: "First Login"} }
        format.html { redirect_to new_api_v1_user_authentication_path }
      end
      return
    end unless token

    begin
      decoded = JsonWebToken.decode(token || session[:token])
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      session.delete(:token)
      render status: :not_found, json: { message: e.message }
    rescue JWT::DecodeError => e
      render status: :unauthorized, json: { message: e.message }
    end
  end
end
