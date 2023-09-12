class DishSerializer < ActiveModel::Serializer
  attributes :id, :dish_name, :dish_images
  def dish_images
    object.dish_images.map do |image|
      Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) if object.dish_images.attached?
    end
  end
end
