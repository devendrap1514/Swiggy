# http://railscasts.com/episodes/219-active-model?language=en&view=asciicast

# this model exist without table
class UserAuthentication
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Naming

  attr_accessor :username, :password
  validates :username, format: { with: /\A[0-9A-Za-z_]+\z/ }
  validates :password, format: { with: /\A(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,}\z/ }

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

  def is_valid_password?
    user = User.find_by_username(username)
    if user
      if user&.authenticate(password)
        true
      else
        errors.add(:base, "username and password doesn't match")
        false
      end
    else
      errors.add(:base, "user doesn't exist")
      false
    end
  end

  def persisted?
    false
  end
end
