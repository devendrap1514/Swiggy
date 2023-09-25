module AuthenticationManager
  extend ActiveSupport::Concern

  def login
    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render status: :ok, json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'),
                                  username: @user.username }
      response.headers['Token'] = token
    else
      render status: :unauthorized, json: { error: 'unauthorized' }
    end
  end
end
