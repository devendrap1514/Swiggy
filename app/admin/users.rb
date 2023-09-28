ActiveAdmin.register User do

  filter :name
  filter :username
  filter :email

  permit_params(:name, :username, :email, :password, :password_confirmation)
  
end
