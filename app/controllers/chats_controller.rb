class ChatsController < ApplicationController
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end

    @chats = @room.chats.order(created_at: :DESC)
    @chat = Chat.new(room_id: @room.id)
    redirect_to user_path(current_user) unless current_user.following?(@user) && current_user.followed?(@user)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    redirect_back(fallback_location: root_path)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
