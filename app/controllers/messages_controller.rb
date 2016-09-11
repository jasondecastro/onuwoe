class MessagesController < ApplicationController
	def create
		message = Message.new(message_params)
		message.player = current_user.player
		message.game = current_game

		if message.save
			ActionCable.server.broadcast('messages', message: message.content, player: current_user.player.nickname)
			head :ok
		end
	end

	private

	def message_params
		params.require(:message).permit(:content)
	end
end