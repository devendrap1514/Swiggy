Rails.application.routes.draw do
  resources :users, only: [:index]
  resources :owners, param: :_username, only: [:create, :show, :update, :destroy]
  resources :customers, param: :_username, only: [:create, :show, :update, :destroy] do
    resource :cart, only: [:show, :destroy]
    resources :orders, only: [:index, :create, :show, :destroy]
  end
  resources :restaurants, param: :_restaurant_name, only: [:index, :create, :show, :update, :destroy]
  resources :dishes, param: :_dish_name, only: [:index, :create, :show, :update, :destroy]
  resources :categories, param: :_category_name, only: [:index, :create, :show, :update]
  resources :restaurant_dishes, param: :_restaurant_dish_id, only: [:index, :create, :show, :update, :destroy]

  scope '/cart' do
    resources :item_statuses, path: "items", only: [:create]
  end

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
