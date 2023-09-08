class Customer < User
  has_one :cart, foreign_key: :user_id, dependent: :destroy
  has_many :orders, foreign_key: :user_id, dependent: :destroy

  after_create :create_empty_cart

  def create_empty_cart
    c = self.create_cart(cart_price: 1)
    p c.errors.full_messages
  end

end
