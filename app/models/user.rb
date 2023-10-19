# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  type                   :string           not null
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_picture

  validates :name, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       format: { with: /\A[0-9A-Za-z_]+\z/ } # allow only alphanumeric and underscore
  validates :password, format: { with: /\A(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,}\z/ } # contain atleast one small and capital letter, a number
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :type, presence: true

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
    false
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
