ActiveAdmin.register Dish do
	filter :dish_name

  form do |f|
    f.inputs do
      # attributes_names return array of key
      # f.semantic_errors *f.object.errors.attribute_names
      f.input :dish_name
      f.input :category_id
      f.semantic_errors :category
      f.input :dish_images, as: :file, input_html: { multiple: true }
    end
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

  show do |dish|
    attributes_table do
      row :id
      row :dish_name
      row :category do |dish|
        dish.category.category_name
      end
      row :updated_at
      row :created_at
    end
  end

  controller do
  end

  permit_params(:dish_name, :category_id, dish_images: [])
end
