ActiveAdmin.register Cart do

  index do
    column :id
    column :user do |cart|
      "#{cart.user_id}, #{cart.customer.name}"
    end
    column :created_at
    column :updated_at
    actions
  end

  show do |cart|
    attributes_table do
      row :id
      row :user do |cart|
        "#{cart.user_id}, #{cart.customer.name}"
      end
      row :created_at
      row :updated_at
    end
  end
end
