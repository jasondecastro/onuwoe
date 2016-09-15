class GamesController < ApplicationController
	before_action :authorize

	def new
		@game = Game.new

	end

	def create
		game = GameGenerator.create_game(current_user)

		redirect_to game_path(game)
	end


	def show
	  	@game = Game.find(params[:id])
	    @nickname = Player.find_by(user_id: current_user.id)
	    @message = Message.new

	    if @game.full_and_no_cards?
			@game.assign_cards
		elsif @game.full?
			@game.change_round
	    end

	    redirect_to game_round_path(game_id: @game.id, id: @game.current_round.id)
	end

	def play
		@game = current_game
		@message = Message.new

	  	GameGenerator.current_user_player(@game, current_user)
		# @game.players.each do |player|
	 #      if player.user_id == current_user.id
	 #        @player = player
	 #      end
	 #  	end


	 	# Is this used?
	  	if params[:name] == nil
	  		#if there are no params, a form needs to be displayed
	  		@display = @game.current_round.display_page(current_user)
	  	else
	  		# if there are params, a form has been sent, and the results need to be displayed
	  		@display = @game.current_round.result_page(current_user, params)

	  	end
    end

    def seer
    	player = Player.find(params.keys[0])
    	# CardActionGenerator.seer_action
    	role = player.final_card
    	name = player.nickname

    	respond_to do |format|
    		format.json { render json: {role: role, name: name}}
    	end
    end

    # CardActionGenerator.some_action
    def robber
    	robbed_player = Player.find(params.keys[0])
    	robbed_player_role = robbed_player.final_card
    	robbed_player_name = robbed_player.nickname

    	robber = current_user.player
    	robber_role = robber.final_card

    	robbed_player.update(final_card: robber_role)
    	robber.update(final_card: robbed_player_role)

    	respond_to do |format|
    		format.json { render json: {robbed_name: robbed_player_name, robbed: robbed_player.final_card}}
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

    def vote
     	player = Player.find(params.keys[0])
     	role = player.final_card
     	name = player.nickname

     	player.votes += 1
     	player.save

     	respond_to do |format|
         format.json { render json: {name: name}}
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
