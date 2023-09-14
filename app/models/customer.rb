class Customer < User
  has_one :cart, foreign_key: 'user_id', dependent: :destroy
  has_many :orders, foreign_key: 'user_id', dependent: :destroy

  after_create :create_empty_cart

  def create_empty_cart
    create_cart
  rescue Exception => e
    render json: 'cart not created'
  end
end
