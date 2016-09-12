class RoundsController < ApplicationController
  before_action :current_game

  def show
    # binding.pry
    # create play in round model
    # need to refactor this for current round
    round = current_game.current_round

    round.play
    head :ok

    redirect_to game_play_path(current_game)
  end

  def get_player
    respond_to do |format|
      format.json { render json: { user_id: current_user.id, role: current_user.player.card.role } }
    end
  end

  def play
    ActionCable.server.broadcast 'rounds',
          content: "BLAH BLAH",
          role: current_user.player.card.role,
          players: "BLAH BLAH",
          round: "1"
    head :ok
    sleep(30)
    ActionCable.server.broadcast 'rounds',
          content: "BLAH BLAH",
          role: current_user.player.card.role,
          players: "BLAH BLAH",
          round: "2"
    head :ok
    sleep(30)
    ActionCable.server.broadcast 'rounds',
          content: "BLAH BLAH",
          role: current_user.player.card.role,
          players: "BLAH BLAH",
          round: "3"
    head :ok
    sleep(30)
    ActionCable.server.broadcast 'rounds',
          content: "BLAH BLAH",
          role: current_user.player.card.role,
          players: "BLAH BLAH",
          round: "4"
    head :ok
    sleep(30)
  end

  def round2

  end

end
