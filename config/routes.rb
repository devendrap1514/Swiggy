Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  resource :user_authentication, path: "auth", only: [:create, :destroy] do
    collection do
      # get '/forgot_password', action: "forgot_password"
      post '/send_mail', action: :send_mail
      # get '/reset_password', action: :reset_password
      post '/set_password', action: :set_password
    end
  end

  # resources :user, only: %i[show update destroy] do

  # end

  resource :owner, only: %i[create show update destroy] do
    get '/my_restaurant', action: :my_restaurant, on: :member
    get '/my_dishes', action: :my_dishes, on: :member
  end

  resource :customer, only: %i[create show update destroy]

  resource :cart, only: %i[show destroy] do
    resources :cart_items, only: %i[create show update destroy]
  end

  resources :orders, only: %i[index create show destroy] do
    resources :order_items, only: [:index]
  end

  resources :restaurants, only: %i[index create show update destroy] do
    get '/dishes', action: :restaurant_dishes, on: :member
  end

  resources :dishes, only: %i[index show create update]
  resources :categories, only: %i[index show] do
    get '/dishes', action: :category_dishes, on: :member
  end

  resources :restaurant_dishes, only: %i[index create show update destroy]

  # get '/*a', to: 'application#not_found'
end
