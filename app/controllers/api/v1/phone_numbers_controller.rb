class Api::V1::PhoneNumbersController < Api::V1::ApiController
  include Api::V1::TwilioHelper
  skip_before_action :authenticate_user!

  def new
  end

  def create
    if params[:phone_number].to_s.size == 10 && !params[:country_code].to_s.blank?
      if send_message
        redirect_to "#{otp_new_api_v1_phone_numbers_path}?country_code=#{params[:country_code]}&phone_number=#{params[:phone_number]}"
      else
        flash.now[:notice] = "error while sending otp. retry"
        render :new
      end
    else
      flash.now[:notice] = "wrong info"
      render :new
    end
  end

  def otp_new
    if session[:phone_number] == nil?
      redirect_to new_api_v1_phone_number_path
    end
    if current_user
      redirect_to root_path
    end
  end

  def verify_otp
    phone_number = session[:phone_number]
    otp = session[:otp]
    otp_expire = session[:otp_expire]
    if phone_number == params[:phone_number] && otp == params[:otp] && otp_expire.to_s.to_datetime < Time.now.to_s.to_datetime && Time.now.to_s.to_datetime < (otp_expire.to_datetime + 3.minutes).to_s.to_datetime
      remove_otp_session()
      setup_user(phone_number)
    else
      flash.now[:alert] = "Invalid OTP or OTP expire"
      render :otp_new
    end
  end

  def setup_user(_phone_number)
    @user = User.from_number(_phone_number)
    # when user present in database
    if @user.persisted?
      sign_out_all_scopes
      sign_in_and_redirect @user, event: :authentication
    elsif @user.id == nil
      redirect_to "#{new_api_v1_auth_registration_path}?name=#{@user.name}&uid=#{@user.uid}&provider=#{@user.provider}&avatar_url=#{@user.avatar_url}&email=&username=#{@user.username}&phone_number=#{@user.phone_number}"
    else
      redirect_to new_user_session_path
    end
  end

  def send_message
    country_code = params[:country_code]
    to = params[:phone_number]
    otp = generate_otp
    body = "your swiggy otp is #{otp}"

    response = send_whatsapp_message(country_code, to, body)
    flash.now[:notice] = 'Message sent successfully'
    set_otp_session(otp)
    response
  rescue Exception => e
    render json: "Something went wrong"
  end

  def remove_otp_session
    session.delete(:phone_number)
    session.delete(:otp)
    session.delete(:otp_expire)
  end

  def set_otp_session(_otp)
    session[:phone_number] = params[:phone_number]
    session[:otp] = _otp
    session[:otp_expire] = Time.now
  end

  def generate_otp
    Array.new(6) { rand(10) }.join
  end
end
