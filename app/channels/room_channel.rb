class RoomChannel < ApplicationCable::Channel
  def subscribed
    # @recipient = User.find_by(id: params[:recipient_id])
    stream_from "room_channel_#{params[:recipient_id]}"
    # stream_for @recipient
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("room_channel_#{@message.recipient_id}", data)
    # ActionCable.server.broadcast @recipient, data
  end
end
