class MessagesController < ApplicationController
  before_action :authorize_request #, except: :create
  before_action :set_chat
  def create
    @message = @chat.messages.new(message_params)
    @message.user = @current_user
    if @message.save
      serialized_data = MessageSerializer.new(@message).serializable_hash
      ChatChannel.broadcast_to @chat, serialized_data
      render json: serialized_data
    else
      render json: @message.errors
    end
  end

  def user_to_user_chat
    return render json: {message: "#{@chat.name} is not private chat room"} unless @chat.private?
    if params[:message][:recipient_id].present?
      @recipient =  User.find_by(id:  params[:message][:recipient_id])
      return render json: {message: "Recipient not found with this Id = #{params[:message][:recipient_id]}"} if @recipient.nil?
      return render json: {message: "You can't start a chat with yourself"} if @current_user.id == params[:message][:recipient_id].to_i

      # @message = @chat.messages.new(message_params)
      @message = @chat.messages.new(params[:message].permit!)
      @message.user = @current_user
      if @message.save
        serialized_data = RecipientMessageSerializer.new(@message).serializable_hash
        # RoomChannel.broadcast_to @recipient, serialized_data
        ActionCable.server.broadcast("room_channel_#{@message.recipient_id}", serialized_data)
        render json: serialized_data
      else
        render json: @message.errors
      end
    else
      render json: {message: "recipient id should present for one to one conversation"}
    end
  end
  private
  def set_chat
    @chat = Chat.find_by(id: params[:chat_id])
    return render json:{messge: "chat room not found"} if @chat.nil?
  end

  def message_params
    # params.require(:message).permit(:content, :chat_id, :user_id, :recipient_id, images:[])
    params.require(:message).permit(:content, :recipient_id, images: [])
  end
end
