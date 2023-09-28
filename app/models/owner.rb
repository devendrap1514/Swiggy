class Owner < User
  has_many :restaurants, foreign_key: 'user_id', dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "password_digest", "reset_password_sent_at", "reset_password_token", "type", "updated_at", "username"]
  end
end
