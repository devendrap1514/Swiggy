module ControllerHelpers
  def user_login(user)
    request.headers["Authorization"] = JsonWebToken.encode(user_id: user.id)
  end
end
