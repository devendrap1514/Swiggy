ActiveAdmin.register Restaurant do
  menu parent: "RestaurantDish"

  permit_params(:restaurant_name, :owner_id, :address)

  filter :restaurant_name
  filter :address

  index do
    render 'admin/restaurants/index', context: self
  end

  show do |restaurant|
    render 'admin/restaurants/show', context: self
  end
end
