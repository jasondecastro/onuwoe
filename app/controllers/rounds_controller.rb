class RoundsController < ApplicationController
  before_action :current_game

  def show
    # create play in round model
    binding.pry
    # need to refactor this for current round
    round = current_game.current_round

    @game = current_game
    if !@game.players.last.card
      @game.assign_cards
    end
    #remove state
    @game.update(state: 1)
    @game.players.each do |player|
      if player.user_id == current_user.id
        @player = player
      end
    end

    round.play

    redirect_to game_path(@game)
    #there will be logic in the game show page that will render certain content depending on the round of the game
  end

  def round2

  end

end

#l
