class RoundsChannel < ApplicationCable::Channel
	def subscribed
		stream_from 'rounds'
	end
end