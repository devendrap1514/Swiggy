class Api::V1::RoomsController < Api::V1::ApiController

  def index
    redirect_to '' unless @current_user
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)

    @room = Room.new
  end

  def create
    @room = @current_user.rooms.create(room_params)
  end

  def show
    @single_room = Room.find(params[:id])
    @message = Message.new
    @messages = @single_room.messages
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
