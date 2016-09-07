class GamesController < ApplicationController

	def new
		@game = Game.new
		@random_game = Game.where('state = 0').first
	end

	def create
		# binding.pry
		@game = Game.create(state: 0)
		@game.players << Player.create(user_id: User.create(name: "Jason").id, nickname: "jasonator")
		redirect_to game_path(@game)
	end

	def show
		binding.pry
	end

	private

	def game_params
		params.require(:game).permit(:user)
	end

end
