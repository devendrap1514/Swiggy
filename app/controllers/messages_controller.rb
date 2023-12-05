class MessagesController < ApplicationController
  def index
    @messages = Message.includes(:user).page(params[:page])
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
    else
    end
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
