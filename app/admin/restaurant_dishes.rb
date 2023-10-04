ActiveAdmin.register RestaurantDish do

  filter :price

  form do |f|
    f.inputs do
      f.input :dish_id
      f.semantic_errors :dish
      f.input :restaurant_id
      f.semantic_errors :restaurant
      f.input :price
    end
    f.actions
  end

  index do
    column :id
    column :restraurant_name do |r|
      link_to(r.restaurant.restaurant_name, admin_restaurant_path(r.restaurant.id))
    end
    column :dish_name do |r|
      link_to(r.dish.dish_name, admin_dish_path(r.dish.id))
    end
    column :price
    actions
  end

  show do |restaurant_dish|
    restaurant = restaurant_dish.restaurant
    dish = restaurant_dish.dish

    attributes_table do
      row :id
      row :restaurant do
        link_to restaurant.restaurant_name, admin_restaurant_path(restaurant.id)
      end
      row :dish do
        link_to dish.dish_name, admin_dish_path(dish.id)
      end
      row :price
    end
  end

  permit_params(:restaurant_id, :dish_id, :price)
  
end
