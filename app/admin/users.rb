ActiveAdmin.register User do

  permit_params(:type, :name, :username, :email, :password, :password_confirmation)

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
    end
  end

  index do
    render 'admin/users/index', context: self
  end

  show do |user|
    render 'admin/users/show', context: self
  end

  controller do
  end
  
end
