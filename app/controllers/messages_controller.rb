class MessagesController < ApplicationController
   before_action :authorize_request #, except: :create
  def create
    binding.pry
    @chat = Chat.find_by(id: params[:chat_id])
     render json:{messge: "chat room not found"} if @chat.nil?
      @message = @chat.messages.new(message_params)
      @message.user = @current_user
      if @message.save
        serialized_data = ActiveModelSerializers::Adapter::Json.new(MessageSerializer.new(@message)).serializable_hash
        # ActionCable.server.broadcast "ChatChannel_#{@chat.id}", message: {data: serialized_data}
        ChatChannel.broadcast_to @chat, serialized_data
        render json: @message
    else
      render json: @message.errors
    end
  end
  private
  def message_params
    params.require(:message).permit(:content, :chat_id, :user_id, :image)
  end
end
