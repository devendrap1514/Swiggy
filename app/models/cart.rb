class Cart < ApplicationRecord
  belongs_to :user
  has_many :items, as: :item, dependent: :destroy
end
