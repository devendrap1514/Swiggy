ActiveAdmin.register User do

  permit_params(:type, :name, :username, :email, :password, :password_confirmation, :profile_picture)

  actions :all, except: [:edit, :update]

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
      input :profile_picture, as: :file
    end
    actions
  end

  index do
    render 'admin/users/index', context: self
  end

  index as: :grid do |user|
    link_to image_tag(user.profile_picture_blob), admin_user_path(user) if user.profile_picture.attached?
  end

  show do |user|
    render 'admin/users/show', context: self
  end

  controller do
  end
  
end
