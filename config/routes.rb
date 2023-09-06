Rails.application.routes.draw do
  resources :users, only: [:index]
  resources :owners, param: :_username, only: [:create, :show, :update, :destroy]
  resources :customers, param: :_username, only: [:create, :show, :update, :destroy]

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
