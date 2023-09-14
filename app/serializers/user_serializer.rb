class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :profile_picture
  def profile_picture
    return unless object.profile_picture.attached?

    Rails.application.routes.url_helpers.rails_blob_url(object.profile_picture,
                                                        only_path: true)
  end
end
