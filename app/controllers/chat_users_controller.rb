class ChatUsersController < ApplicationController
  # Require authentication before any action in this controller
  before_action :authorize_request
  before_action :set_chat

  def create
    @chat_user = @chat.chat_users.where(user_id: @current_user.id).first_or_create
    render json: @chat
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end
end