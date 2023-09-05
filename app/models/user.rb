class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                        format: { with: /\A[0-9A-Za-z_]+\z/ }  # allow only alphanumeric and underscore
  validates :password, format: { with: /\A(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}\z/ }  # contain atleast one small and capital letter, a number and a underscore
  validates :first_name, :last_name, presence: true

  before_validation :remove_whitespace

  def remove_whitespace
    self.first_name = self.first_name.strip.squeeze(" ")
    self.last_name = self.last_name.strip.squeeze(" ")
    self.email = self.email.gsub(/\s+/, "") # replace all whitespace with nothing
  end
end
