class Customer < User
  has_one :cart, foreign_key: 'user_id', dependent: :destroy
  has_many :orders, foreign_key: 'user_id', dependent: :destroy
end
