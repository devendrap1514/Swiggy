ActiveAdmin.register Dish do
  menu parent: "RestaurantDish"

  permit_params(:dish_name, :category_id, dish_images: [])

	filter :dish_name

  form do |f|
    render 'admin/dishes/form', context: self
  end

	index do
    render 'admin/dishes/index', context: self
	end

  show do |dish|
    render 'admin/dishes/show', context: self
  end

  controller do
  end
end
