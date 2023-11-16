# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar_url             :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  type                   :string           not null
#  uid                    :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username)
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :omniauthable, omniauth_providers: [:google_oauth2, :facebook, :twitter], authentication_keys: [:username]

  has_one_attached :profile_picture

  validates :name, presence: true

  # allow only alphanumeric and underscore
  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[0-9A-Za-z_]+\z/ }

  # contain atleast one small and capital letter, a number
  # validates :password, format: { with: /\A(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,}\z/, message: "contain atleast a-z, A-Z, 0-9 with 6 letter" }, unless: password.nil?
  validates_confirmation_of :password

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :type, presence: true

  before_validation :remove_whitespace

  # after_create :send_welcome_mail

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.username = Faker::Internet.username(separators: ['_'])
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
    end
  end

  def remove_whitespace
    self.name = StripAndSqueeze.apply(name)
    # replace all whitespace with nothing and small case
    self.username = username.gsub(/\s+/, '').downcase unless username.nil?
    self.password = password.gsub(/\s+/, '') unless password.nil? # replace all whitespace with nothing
  end

  def send_welcome_mail
    # this work when redis-server running and execute after sidekiq
    UserMailer.with(user: self).welcome_email.deliver_later if self.email
  end
end
