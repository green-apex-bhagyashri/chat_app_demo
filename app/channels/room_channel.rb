class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "room_channel_#{params[:user_id]}"
    # stream_from "some_channel"
    @recipient = User.find_by(id: params[:recipient_id])
    stream_for @recipient
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast @recipient, data
  end
end
