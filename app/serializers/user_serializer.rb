class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :profile_picture
  def profile_picture
    Rails.application.routes.url_helpers.rails_blob_url(object.profile_picture, only_path: true) if object.profile_picture.attached?
  end
end
