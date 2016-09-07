class GamesController < ApplicationController
	before_action :authorize

	def new
		@game = Game.new
		
	end

	def create
		# binding.pry
		@game = Game.create(state: 0)
		@player = Player.create(user_id: current_user.id, nickname: current_user.name + " (the creator)")
		@game.players << @player
		# binding.pry
		redirect_to game_path(@game)
	end

	def join
		@random_game = Game.where('state = 0').first
		@player = Player.find_or_create_by(user_id: current_user.id)
		@player.nickname = current_user.name
		unless @random_game.players.include?(@player) 
			@random_game.players << @player
		end
		redirect_to game_path(@random_game)
	end

	def show
		@game = Game.find(params[:id])
	end

	def destroy
		Game.destroy_all
	end	

	private

	def game_params
		params.require(:game).permit(:user)
	end

end
