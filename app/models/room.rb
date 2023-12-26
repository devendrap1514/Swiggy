# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  is_private :boolean          default(FALSE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_rooms_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Room < ApplicationRecord

  belongs_to :user
  has_many :messages

  validates_uniqueness_of :name
  scope :public_rooms, -> { where(is_private: false) }

  after_create_commit {broadcast_append_to "rooms", partial: "api/v1/rooms/room" }
end
