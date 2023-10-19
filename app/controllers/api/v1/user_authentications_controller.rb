class Api::V1::UserAuthenticationsController < Api::V1::ApiController
  #---------don't use before_action bcz it will not execute authorize_request before authorise_resource
  skip_before_action :authorize_request, only: %i[new create destroy send_mail set_password]

  def new
    if is_login?
      redirect_to api_v1_restaurant_dishes_path
    end
    @user_authentication = UserAuthentication.new
  end

  def create
    @user_authentication = UserAuthentication.new(user_authentication_params)
    if @user_authentication.is_match?
      user = @user_authentication.get_user
      token = JsonWebToken.encode(user_id: user.id)
      session[:token] = token
      output = {}
      output[:message] = "Successfully Login"
      response.headers['Token'] = token
      respond_to do |format|
        format.json { render status: :ok, json: output }
        format.html { redirect_to api_v1_restaurant_dishes_path }
      end
    else
      output = {}
      output[:message] = "username & possword doesn't match"
      respond_to do |format|
        format.json { render status: :unauthorized, json: output }
        format.html { render :new }
      end
    end
  end

  def destroy
    session.delete(:token)

    output = {}
    output[:message] = "Successfully Logout"
    respond_to do |format|
      format.json { render status: :ok, json: output }
      format.html { redirect_to new_api_v1_user_authentication_path }
    end
  end

  def forgot_password
  end

  def send_mail
    if !params[:username] || params[:username].empty?
      flash.now[:notice] = "Username must be pass"
      respond_to do |format|
        format.json { render status: :not_found, json: 'Username must be pass' }
        format.html { render :forgot_password }
      end and return
    end

    user = User.find_by_username(params[:username])
    if user.present?
      user.generate_password_token! # generate pass token
      UserMailer.with(user:user).forgot_password_token.deliver_now
      respond_to do |format|
        format.json { render json: 'Email Send Successfully' }
        format.html { redirect_to reset_password_api_v1_user_authentication_path }
      end
    else
      flash.now[:notice] = "username not found"
      respond_to do |format|
        format.json { render json: { message: ['Username not found. Please check and try again.'] }, status: :not_found }
        format.html { render :forgot_password }
      end
    end
  end

  def reset_password
    @user = User.new
  end

  def set_password
    token = params[:token]

    if !token || token.empty?
      flash.now[:notice] = "Token not present"
      respond_to do |format|
        format.json { render status: :not_found, json: { error: 'Token not present' } }
        format.html { render :reset_password }
      end and return
    end

    @user = User.find_by(reset_password_token: token)
    if @user.present? && @user.password_token_valid?
      if @user.reset_password!(params[:password])
        respond_to do |format|
          format.json { render json: 'Password Update Successfully' }
          format.html { redirect_to new_api_v1_user_authentication_path }
        end
      else
        respond_to do |format|
          format.json { render status: :unprocessable_entity, json: { errors: @user.errors.full_messages } }
          format.html { render :reset_password }
        end
      end
    else
      flash.now[:notice] = 'Link not valid or expired. Try generating a new link.'
      respond_to do |format|
        format.json { render status: :gone, json: { message: ['Link not valid or expired. Try generating a new link.'] } }
        format.html { render :reset_password }
      end
    end
  end

  private
  def user_authentication_params
    params.require(:user_authentication).permit(:username, :password)
  end
end
