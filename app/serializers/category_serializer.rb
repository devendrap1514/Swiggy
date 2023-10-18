# == Schema Information
#
# Table name: categories
#
#  id            :bigint           not null, primary key
#  category_name :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class CategorySerializer < ActiveModel::Serializer
  attributes :id, :category_name
end
