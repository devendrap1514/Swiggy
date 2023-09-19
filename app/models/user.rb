class User < ApplicationRecord
  has_secure_password

  has_one_attached :profile_picture
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       format: { with: /\A[0-9A-Za-z_]+\z/ } # allow only alphanumeric and underscore
  validates :password, format: { with: /\A(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,}\z/ }, if: -> { new_record? || password_digest_changed? } # contain atleast one small and capital letter, a number
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation :remove_whitespace

  def remove_whitespace
    self.name = StripAndSqueeze.apply(name)
    # replace all whitespace with nothing and small case
    self.username = username.gsub(/\s+/, '').downcase unless username.nil?
    self.password = password.gsub(/\s+/, '') unless password.nil? # replace all whitespace with nothing
  end

  # forgot and reset password method
  def generate_password_token!
    update(reset_password_token: generate_token, reset_password_sent_at: Time.now.utc)
  end

  def password_token_valid?
    (reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(_password)
    return update(reset_password_token: nil) if update(password: _password)
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
