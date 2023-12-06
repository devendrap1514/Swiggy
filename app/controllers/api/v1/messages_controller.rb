class Api::V1::MessagesController < Api::V1::ApiController
  before_action :find_message

  def index
    @messages = Message.includes(:user).page(1)
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
    else
    end
  end

  def edit
  end

  def update
    return unless @message.user == current_user
    if @message.update(message_params)
    else
    end
  end

  def destroy
    return unless @message.user == current_user
    @message.destroy
  rescue

  end

  def find_message
    @message = Message.find_by_id(params[:id])
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
