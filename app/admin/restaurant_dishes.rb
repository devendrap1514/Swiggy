ActiveAdmin.register RestaurantDish do
  menu label: "Restaurant with Dish"
  menu parent: "RestaurantDish"

  permit_params(:restaurant_id, :dish_id, :price)

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
    render 'admin/restaurant_dishes/index', context: self
  end

  show do |restaurant_dish|
    render 'admin/restaurant_dishes/show', context: self
  end
end
