# == Schema Information
#
# Table name: categories
#
#  id            :bigint           not null, primary key
#  category_name :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }

  it 'is valid with valid attributes' do
    expect(category).to be_valid
  end

  it 'is not valid without a category_name' do
    category.category_name = nil
    expect(category).to_not be_valid
  end

  describe 'Outputs' do
  end
end
