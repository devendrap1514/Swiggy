ActiveAdmin.register Restaurant do

  filter :restaurant_name
  filter :address

  index do
    column :id
    column :restaurant_name
    column :address
    column :created_at
    column :updated_at
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
      row :created_at
      row :updated_at
      row :dishes_count do |restaurant|
        restaurant.dishes.count
      end
    end
  end

  permit_params(:restaurant_name, :user_id, :address)
end
