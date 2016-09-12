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

		binding.pry

		redirect_to game_path(@random_game)
	end

	def show

	  	@game = Game.find(params[:id])

	    @nickname = Player.find_by(user_id: current_user.id)

	    @message = Message.new

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
	  	
	  	params[:name]
	  	params[:role]

    end

    def seer
    	player = Player.find(params.keys[0])
    	role = player.final_card
    	name = player.nickname

    	respond_to do |format| 
    		format.json { render json: {role: role, name: name}}
    	end
    end

    def robber
    	robbed_player = Player.find(params.keys[0])
    	robbed_player_role = robbed_player.final_card
    	robbed_player_name = robbed_player.nickname

    	robber = current_user.player
    	robber_role = robber.final_card

    	robbed_player.update(final_card: robber_role)
    	robber.update(final_card: robbed_player_role)

    	respond_to do |format| 
    		format.json { render json: {robber: robber.final_card, robbed: robbed_player.final_card}}
    	end
    end

    def troublemaker
    	first = Player.find(params.keys[0])
    	first_role = first.final_card
    	first_name = first.nickname

    	second = Player.find(params.keys[1])
    	second_role = second.final_card
    	second_name = second.nickname

    	first.update(final_card: second_role)
    	second.update(final_card: first_role)

    	respond_to do |format| 
    		format.json { render json: {first: first_name, second: second_name}}
    	end
    end

	def destroy
		Game.destroy_all
	end

	private

	def game_params
		params.require(:game).permit(*args)
	end

end
