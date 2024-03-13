class ChatChannel < ApplicationCable::Channel
  MAX_USERS = 2
  def subscribed
    @chat = Chat.find_by(id: params[:chat_id])
    # if @chat.users.count <= MAX_USERS
      stream_for @chat
    # else
    #   reject
    # end
  end

  def receive(data)
    ActionCable.server.broadcast @chat, data
  end

  def unsubscribed
    @chat = Chat.find_by(id: params[:chat_id])
    # broadcast_user_count(@chat)
  end

  private

  def broadcast_user_count(chat)
    ActionCable.server.broadcast(chat, { user_count: @chat.users.count })
  end
end
