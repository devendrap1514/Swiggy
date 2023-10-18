# == Schema Information
#
# Table name: dishes
#
#  id          :bigint           not null, primary key
#  dish_name   :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_dishes_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class DishSerializer < ActiveModel::Serializer
  attributes :id, :dish_name, :dish_images
  belongs_to :category
  def dish_images
    object.dish_images.map do |image|
      Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) if object.dish_images.attached?
    end
  end
end
