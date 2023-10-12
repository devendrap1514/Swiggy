# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  name                   :string           not null
#  password_digest        :string           not null
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  type                   :string           not null
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :profile_picture
  def profile_picture
    return unless object.profile_picture.attached?

    Rails.application.routes.url_helpers.rails_blob_url(object.profile_picture, only_path: true)
  end
end
