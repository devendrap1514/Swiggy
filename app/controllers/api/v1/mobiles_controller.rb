class Api::V1::MobilesController < Api::V1::ApiController
  include Api::V1::TwilioHelper
  skip_before_action :authenticate_user!

  def new
  end

  def create
    if params[:phone_number].to_s.size == 10 && !params[:country_code].to_s.blank?
      respond_to do |format|
        if send_message
          format.html{ redirect_to "#{api_v1_otp_new_path}?country_code=#{params[:country_code]}&phone_number=#{params[:phone_number]}" }
        else
          respond_to do |format|
            flash.now[:notice] = "error while sending otp. retry"
            format.html{ render :new }
          end
        end
      end
    else
      respond_to do |format|
        flash.now[:notice] = "wrong info"
        format.html{ render :new }
      end
    end
  end

  def otp_new
  end

  def verify_otp

  end

  def send_message
    country_code = params[:country_code]
    to = params[:phone_number]
    body = otp

    op = send_whatsapp_message(country_code, to, body)
    byebug
    flash[:notice] = 'Message sent successfully'
    op
  end

  def otp
    Rails.cache.fetch("otp/#{params[:phone_number]}", expires_in: 3.minutes) do
      Array.new(6) { rand(10) }.join
    end
  end
end
