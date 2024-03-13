class ChatsController < ApplicationController
  before_action :authorize_request
  def create 
    @chat = Chat.new(chat_params)
    if @chat.save
      @chat.chat_users.where(user_id: @current_user.id).first_or_create
      render json: @chat
    else
       render json: @chat.errors
    end

  end

  private

  def chat_params
    params.require(:chat).permit(:name, :private)
  end
end
