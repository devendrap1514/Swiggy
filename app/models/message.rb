# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_messages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Message < ApplicationRecord
  paginates_per 20

  belongs_to :user

  validates :text, presence: true

  after_create_commit {broadcast_append_to "messages"}

  default_scope { order(created_at: :asc ) }
end
