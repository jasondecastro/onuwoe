class GamesController < ApplicationController
	before_action :authorize

	def new
		@game = Game.new

	end

	def create
		@game = Game.create(state: 0)
		@player = Player.create(user_id: current_user.id, nickname: current_user.name + " (the creator)")
		@game.players << @player

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

    #once we add ActionCable, we will have to monitor if the game is full or not here
	    if @game.start_game
	      redirect_to game_play_path
	    end
	end

	def play
		binding.pry
		@game = Game.find(params[:id])
		@game.update(state: 1)
		@player = current_user.player
	end

	def destroy
		Game.destroy_all
	end

	private

	def game_params
		params.require(:game).permit(:user)
	end

end
