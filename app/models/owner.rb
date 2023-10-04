class Owner < User
  has_many :restaurants, foreign_key: 'user_id', dependent: :destroy
end
