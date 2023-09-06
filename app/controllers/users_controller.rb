class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  def index
    render json: User.all
  end

  def show
    render json: @user, status: :ok
  end

  def update
    if !@user.update(user_params)
      render json: { errors: @user.errors.full_messages },
              status: :unprocessable_entity
    else
      render json: @user
    end
  end

  def destroy
    render json: @user.destroy
  end

  private
    def find_user
      # to know which username get and what is the current user username
      if params[:_username] == @current_user.username
        @user = User.find_by_username!(params[:_username])
      else
        render json: { errors: 'Specify correct username with this token'}
      end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
    end

    def user_params
      params.permit(:name, :username, :password, :password_confirmation)
    end
end
