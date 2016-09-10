class RoundsController < ApplicationController
  before_action :current_game

  def show
    # binding.pry
    # create play in round model
    # need to refactor this for current round
    round = current_game.current_round

    round.play

    redirect_to game_play_path(current_game)
  end

  def round2

  end

end

#l
