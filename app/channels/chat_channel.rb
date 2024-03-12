class ChatChannel < ApplicationCable::Channel
  def subscribed
    @chat = Chat.find_by(id: params[:chat_id])
    # stream_From "ChatChannel_#{@chat.id}"
    stream_for @chat
    # stream_from "some_channel"
  end

  def receive(data)
    ActionCable.server.broadcast @chat, data
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
