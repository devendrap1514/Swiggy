class Api::V1::UsersController < Api::V1::ApiController

  def create(user)
    UserMailer.with(user: user).welcome_email.deliver_now
  end

  def show
    output = {}
    output[:message] = "success"
    output[:data] = UserSerializer.new @current_user

    respond_to do |format|
      format.json { render json: output }
      format.html { }
    end
  end

  def update
    if @current_user.update(user_params)
      render json: { message: "Update Successfully", data: UserSerializer.new(@current_user) }
    else
      render status: :unprocessable_entity,
             json: { message: @current_user.errors.full_messages }
    end
  end

  def destroy
    @current_user.destroy
    render status: :ok, json: { message:'Deleted Successfully' }
  rescue Exception => e
    render status: :internal_server_error, json: { messages: e.message }
  end

  private

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation, :profile_picture)
  end
end
