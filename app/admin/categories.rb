ActiveAdmin.register Category do
  filter :category_name

  show do |category|
    attributes_table do
      row :id
      row :category_name
    end
    panel "Dishes" do
      table_for category.dishes.joins(:restaurants) do
        column :dish_name
      end
    end
  end

  permit_params(:category_name)
end
