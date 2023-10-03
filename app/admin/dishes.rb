ActiveAdmin.register Dish do
	filter :dish_name

  form do |f|
    f.input :dish_name
    f.input :category_id, as: :select, collection: Category.ids
    f.input :dish_images, as: :file, input_html: { multiple: true }
    f.actions
  end

	index do
    column "Images" do |dish|
      ul do
        dish.dish_images.each do |img|
          li do
            image_tag(img, size: "50x40")
          end
        end
       end
    end
    column :id
    column :dish_name
    column :category do |dish|
      dish.category.category_name
    end
    actions
	end

  controller do
  end

  permit_params(:dish_name, :category_id, dish_images: [])
end
