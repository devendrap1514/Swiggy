class User < ApplicationRecord
  has_secure_password
  has_secure_password validations: false

  has_one_attached :profile_picture
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       format: { with: /\A[0-9A-Za-z_]+\z/ } # allow only alphanumeric and underscore
  validates :password, format: { with: /\A(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,}\z/ },
                       if: -> { new_record? } # contain atleast one small and capital letter, a number
  validates :name, presence: true

  before_validation :remove_whitespace

  def remove_whitespace
    self.name = StripAndSqueeze.apply(name)
    # replace all whitespace with nothing and small case
    self.username = username.gsub(/\s+/, '').downcase unless username.nil?
    self.password = password.gsub(/\s+/, '') unless password.nil? # replace all whitespace with nothing
  end
end
