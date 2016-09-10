class GamesController < ApplicationController
	before_action :authorize

	def new
		@game = Game.new

	end

	def create
		@game = Game.create(state: 0, host: current_user.name)
		@player = Player.create(user_id: current_user.id, nickname: current_user.name)
		@game.players << @player
		@game.create_rounds
		@game.save

		redirect_to game_path(@game)
	end

	def join
		@random_game = Game.where('state = 0').first

		if @random_game == nil
			@random_game = Game.create(state: 0, host: current_user)
		end

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
    if @game.full? && @game.players.first.card == nil
			@game.current_round.round_1
			@game.players.each do |player|
				if player.user_id == current_user.id
					@player = player
				end
			end
		elsif @game.full?
			@game.change_round
			redirect_to game_round_path(game_id: @game.id, id: @game.current_round.id)
    end
	end

	def play
		@game = current_game

		@game.players.each do |player|
	      if player.user_id == current_user.id
	        @player = player
	      end
	  	end

	  	if params[:name] == nil
	  		#if there are no params, a form needs to be displayed
	  		@display = @game.current_round.display_page(current_user)
	  	else 
	  		# if there are params, a form has been sent, and the results need to be displayed
	  		@display = @game.current_round.result_page(current_user, params)
	  	end
	  	binding.pry
	  	
	  	params[:name]
	  	params[:role]

    end

    def search
    	binding.pry
    	player = Player.find(params[:players][:player_id])
    	role = player.card.role
    	name = player.nickname
    	redirect_to game_play_path(current_game, role: role, name: name)
    end

	def destroy
		Game.destroy_all
	end

	private

	def game_params
		params.require(:game).permit(*args)
	end

end
