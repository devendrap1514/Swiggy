module Api::V1::TwilioHelper
  def send_whatsapp_message(country_code, to, body)
    Twilio::REST::Client.new.messages.create(
      from: "whatsapp:+14155238886",
      to: "whatsapp:#{country_code}#{to}",
      body: body
    )
  end
end
