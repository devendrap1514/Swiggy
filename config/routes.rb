Rails.application.routes.draw do
  root 'sessions#welcome_page'

  resource :sessions, only: %i[new create destroy]
  # post '/forgot_password', to: 'sessions#forgot_password'
  # post '/reset_password', to: 'sessions#reset_password'

  # resource :owner, only: %i[create show update destroy] do
  #   get '/my_restaurant', action: :my_restaurant, on: :member
  #   get '/my_dishes', action: :my_dishes, on: :member
  # end

  # resource :customer, only: %i[create show update destroy]

  # resource :cart, only: %i[show destroy] do
  #   resources :cart_items, only: %i[create show update destroy]
  # end

  # resources :orders, only: %i[index create show destroy] do
  #   resources :order_items, only: [:index]
  # end

  # resources :restaurants, only: %i[index create show update destroy] do
  #   get '/dishes', action: :restaurant_dishes, on: :member
  # end

  # resources :dishes, only: %i[index show create update]
  # resources :categories, only: %i[index show]
  # resources :restaurant_dishes, only: %i[index create show update destroy]

  # get '/*a', to: 'application#not_found'
end
