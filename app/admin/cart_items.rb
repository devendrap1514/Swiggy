ActiveAdmin.register CartItem do

  actions :all, except: [:new, :create, :edit, :update, :destroy]

  index do
    render 'admin/cart_items/status', context: self
    render 'admin/cart_items/most_added_item', context: self
    render 'admin/cart_items/index', context: self
  end
end
