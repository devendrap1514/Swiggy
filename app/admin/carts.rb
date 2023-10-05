ActiveAdmin.register Cart do

  index do
    render 'admin/carts/index', context: self
  end

  show do |cart|
    render 'admin/carts/show', context: self
  end
end
