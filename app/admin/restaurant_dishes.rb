ActiveAdmin.register RestaurantDish do

  filter :price

  form do |f|
    f.input :dish_id
    f.input :restaurant_id
    f.input :price
    f.actions
  end

  index do
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
      row :restaurant do
        link_to restaurant.restaurant_name, admin_restaurant_path(restaurant.id)
      end
      row :dish do
        link_to dish.dish_name, admin_dish_path(dish.id)
      end
    end
  end

  permit_params(:restaurant_id, :dish_id, :price)
  
end
