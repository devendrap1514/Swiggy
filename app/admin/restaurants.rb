ActiveAdmin.register Restaurant do

  filter :restaurant_name
  filter :address

  form do |f|

  end

  index do
    column :id
    column :restaurant_name
    column :address
    column :dishes_count do |restaurant|
      restaurant.dishes.count
    end
    column :owner do |restaurant|
      restaurant.owner
    end
    actions
  end

  show do |restaurant|
    attributes_table do
      row :id
      row :restaurant_name
      row :address
      row :dishes_count do |restaurant|
        restaurant.dishes.count
      end
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

  permit_params(:restaurant_name, :user_id, :address)
end
