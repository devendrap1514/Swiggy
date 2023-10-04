ActiveAdmin.register User do
  permit_params(:type, :name, :username, :email, :password, :password_confirmation)

  filter :name
  filter :username
  filter :email
  filter :type

  form do |f|
    f.inputs do
      f.input :type, as: :select, collection: ['Owner', 'Customer']
      f.input :name
      f.input :email
      f.input :username
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  index do
    column :profile do |user|
      image_tag(user.profile_picture, size: "50x40") if user.profile_picture.present?
    end
    column :type
    column :id
    column :username
    column :name
    column :email
    column :created_at
    column :updated_at
    actions
  end

  show do |user|
    attributes_table do
      row :type
      row :id
      row :username
      row :name
      row :email
      row :created_at
      row :updated_at
    end
  end
  
end
