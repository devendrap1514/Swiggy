ActiveAdmin.register Restaurant do

  filter :restaurant_name
  filter :address

  index do
    column :restaurant_name
    column :address
    column :dishes_count do |restaurant|
      restaurant.dishes.count
    end
    actions
  end

  show do |restaurant|
    attributes_table do
      row :restaurant_name
      row :address
    end
    panel 'Dishes' do
      table_for restaurant.dishes do |dish|
        dish.column :dish_name
        column 'category' do |d|
          d.category.category_name
        end
      end
    end
  end
end
