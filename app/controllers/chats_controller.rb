class ChatsController < ApplicationController

	def create 
		@chat = Chat.new(chat_params)
		if @chat.save
			render json: @chat
		else
			 render @chat.errors
		end

	end

	private

	def chat_params
		params.require(:chat).permit(:name)
	end
end
