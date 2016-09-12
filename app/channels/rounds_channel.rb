class RoundsChannel < ApplicationCable::Channel
	def subscribed
    role = User.find(params[:user_id].to_i).player.card.role
		stream_from 'rounds'
	end
end