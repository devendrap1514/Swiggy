ActiveAdmin.register Category do

  permit_params(:category_name)

  filter :category_name

  index do
    render 'admin/categories/index', context: self
  end

  show do |category|
    render 'admin/categories/show', context: self
  end
end
