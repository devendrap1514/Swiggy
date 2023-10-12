module TokenHelper
  def user_token(user)
    JsonWebToken.encode(user_id: user.id)
  end
end
