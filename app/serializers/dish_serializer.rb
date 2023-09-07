class DishSerializer < ActiveModel::Serializer
  attributes :id, :dish_name
  belongs_to :category
end
