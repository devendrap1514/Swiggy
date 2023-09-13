Rails.application.routes.draw do
  resource :owner, only: [:create, :show, :update, :destroy] do
    get '/my_restaurant', action: :my_restaurant, on: :member
    get '/my_dishes', action: :my_dishes, on: :member
  end
  resource :customer, only: [:create, :show, :update, :destroy]
  resource :cart, only: [:show, :destroy] do
    resources :cart_items, param: :_cart_item_id, only: [:create, :destroy]
  end
  resources :orders, param: :_order_id, only: [:index, :create, :show, :destroy] do
    resources :order_items, param: :_order_item_id, only: [:create, :destroy]
  end
  resources :restaurants, param: :_restaurant_id, only: [:index, :create, :show, :update, :destroy] do
    get '/dishes', action: :restaurant_dishes, on: :member
  end
  resources :dishes, param: :_dish_id, only: [:index, :show]
  resources :categories, param: :_category_id, only: [:index, :show]
  resources :restaurant_dishes, param: :_restaurant_dish_id, only: [:index, :create, :show, :update, :destroy]

  resources :searches, path: "search", only: [] do
    get '/search_by_restaurant', action: :search_by_restaurant, on: :collection
    get '/search_by_category', action: :search_by_category, on: :collection
    get '/search_by_dish', action: :search_by_dish, on: :collection
  end

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
