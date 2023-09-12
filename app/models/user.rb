class User < ApplicationRecord
  has_secure_password
  has_secure_password validations: false

  has_one_attached :profile_picture
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                        format: { with: /\A[0-9A-Za-z_]+\z/ }  # allow only alphanumeric and underscore
  validates :password, format: { with: /\A(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,}\z/ },
                        if: -> { new_record? }  # contain atleast one small and capital letter, a number and a underscore
  validates :name, presence: true

  before_validation :remove_whitespace

  def remove_whitespace
    self.name = self.name.strip.squeeze(" ") unless self.name.nil?
    self.username = self.username.gsub(/\s+/, "").downcase unless self.username.nil? # replace all whitespace with nothing and small case
    self.password = self.password.gsub(/\s+/, "") unless self.password.nil? # replace all whitespace with nothing
  end
end
