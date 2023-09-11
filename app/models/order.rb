class Order < ApplicationRecord
  belongs_to :user
  has_many :item_statuses, as: :status, dependent: :destroy


end
