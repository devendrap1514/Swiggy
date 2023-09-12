Rails.application.routes.draw do
  resources :users, only: [:index]
  resources :owners, param: :_username, only: [:create, :show, :update, :destroy] do
    get '/my_restaurant', action: :my_restaurant, on: :member
    get '/my_dishes', action: :my_dishes, on: :member
  end
  resources :customers, param: :_username, only: [:create, :show, :update, :destroy] do
    resource :cart, only: [:show, :destroy]
    resources :orders, param: :_order_id, only: [:index, :create, :show, :destroy]
  end
  resources :restaurants, param: :_restaurant_id, only: [:index, :create, :show, :update, :destroy]
  resources :dishes, param: :_dish_id, only: [:index, :create, :show, :update, :destroy]
  resources :categories, param: :_category_id, only: [:index, :create, :show, :update]
  resources :restaurant_dishes, param: :_restaurant_dish_id, only: [:index, :create, :show, :update, :destroy]

  scope '/cart' do
    resources :items, only: [:create, :destroy]
  end

  resources :searches, path: "search", only: [] do
    get '/search_by_restaurant', action: :search_by_restaurant, on: :collection
    get '/search_by_category', action: :search_by_category, on: :collection
  end

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
