ActiveAdmin.register User do

  filter :name
  filter :username
  filter :email
  filter :type

  index do
    column :profile do |user|
      image_tag(user.profile_picture, size: "50x40") if user.profile_picture.present?
    end
    column :type
    column :id
    column :username
    column :name
    column :email
    column :updated_at
    actions
  end

  show do |user|
    attributes_table do
      row :id
      row :username
      row :name
      row :email
      row :updated_at
    end
  end

  permit_params(:name, :username, :email, :password, :password_confirmation)
  
end
